---
published: true
title: Creating a Statcast MySQL Database
layout: post
date: 2020-07-27T00:00:00.000Z
---
This is largely based off of [Bill Petti's post](https://billpetti.github.io/2020-05-26-build-statcast-database-rstats-version-2.0/) which demonstrates how to use his [baseballr package](https://github.com/BillPetti/baseballr) to gather Statcast data into a database (you can go to that repository for installation instructions).

```{r}
library(baseballr)
library(tidyverse)
library(DBI)
```

Before starting, you need to have access to a database - this will be for MySQL but other database types can be switched in fairly easily. I made a simple custom function that connects to my local database when called

```{r}
source('db_connector.R')
```

That file contains this code, filled in with my database connection information (Note make sure the ODBC driver is installed for MySQL):
```{r}
db_connector <-  function() {
  return(
    DBI::dbConnect(
      odbc::odbc(),
      Driver = "MySQL ODBC 8.0 Unicode Driver",
      Server = '',
      Database = '',
      Trusted_Connection = "True",
      user = '',
      password = ''
    )
  )
}
```

Creating a helper function to scrape statcast data from a given season. It first creates week breaks from the start of February to the end of November and makes a grid for each 7 day interval. It then uses a "safe" version of the baseballr scrape_statcast_savant() to capture errors without stopping the loop. For each date range, the function runs the savant scrape function, makes it into a dataframe if valid data is returned, and making sure the dataframe has data in it before adding it to the larger dataframe.
```{r}
annual_statcast_query <- function(season) {
  dates <- seq.Date(as.Date(paste0(season, '-02-01')),
                    as.Date(paste0(season, '-12-01')), by = 'week')
  
  date_grid <- tibble(start_date = dates,
                      end_date = dates + 6)
  
  safe_savant <- safely(scrape_statcast_savant)
  
  payload <- map(.x = seq_along(date_grid$start_date),
                 ~ {
                   message(paste0('\nScraping week of ', date_grid$start_date[.x], '...\n'))
                   
                   payload <-
                     safe_savant(
                       start_date = date_grid$start_date[.x],
                       end_date = date_grid$end_date[.x],
                       type = 'pitcher'
                     )
                   
                   return(payload)
                 })
  
  payload_df <- map(payload, 'result')
  
  number_rows <- map_df(.x = seq_along(payload_df),
                        ~ {
                          number_rows <- tibble(week = .x,
                                                number_rows = length(payload_df[[.x]]$game_date))
                        }) %>%
    filter(number_rows > 0) %>%
    pull(week)
  
  payload_df_reduced <- payload_df[number_rows]
  
  combined <- payload_df_reduced %>%
    bind_rows()
  
  return(combined)
}
```

Add missing columns in to make sure they're standardized across the database
```{r}
format_append_statcast <- function(df) {
  # function for appending new variables to the data set
  
  additional_info <- function(df) {
    # apply additional coding for custom variables
    
    df$hit_type <-
      with(df, ifelse(
        type == "X" & events == "single",
        1,
        ifelse(
          type == "X" & events == "double",
          2,
          ifelse(
            type == "X" & events == "triple",
            3,
            ifelse(type == "X" &
                     events == "home_run", 4, NA)
          )
        )
      ))
    
    df$hit <- with(df, ifelse(
      type == "X" & events == "single",
      1,
      ifelse(
        type == "X" & events == "double",
        1,
        ifelse(
          type == "X" & events == "triple",
          1,
          ifelse(type == "X" &
                   events == "home_run", 1, NA)
        )
      )
    ))
    
    df$fielding_team <-
      with(df, ifelse(inning_topbot == "Bot", away_team, home_team))
    
    df$batting_team <-
      with(df, ifelse(inning_topbot == "Bot", home_team, away_team))
    
    df <- df %>%
      mutate(
        barrel = ifelse(
          launch_angle <= 50 &
            launch_speed >= 98 &
            launch_speed * 1.5 - launch_angle >= 117 &
            launch_speed + launch_angle >= 124,
          1,
          0
        )
      )
    
    df <- df %>%
      mutate(spray_angle = round((atan(
        (hc_x - 125.42) / (198.27 - hc_y)
      ) * 180 / pi * .75)
      , 1))
    
    df <- df %>%
      filter(!is.na(game_year))
    
    return(df)
  }
  
  df <- df %>%
    additional_info()
  
  df$game_date <- as.character(df$game_date)
  
  df <- df %>%
    arrange(game_date)
  
  df <- df %>%
    filter(!is.na(game_date))
  
  df <- df %>%
    ungroup()
  
  df <- df %>%
    select(setdiff(names(.), c("error")))
  
  cols_to_transform <-
    c(
      "fielder_2",
      "pitcher_1",
      "fielder_2_1",
      "fielder_3",
      "fielder_4",
      "fielder_5",
      "fielder_6",
      "fielder_7",
      "fielder_8",
      "fielder_9"
    )
  
  df <- df %>%
    mutate_at(.vars = cols_to_transform, as.numeric) %>%
    mutate_at(.vars = cols_to_transform, function(x) {
      ifelse(is.na(x), 999999999, x)
    })
  
  data_base_column_types <-
    read_csv("https://app.box.com/shared/static/q326nuker938n2nduy81au67s2pf9a3j.csv")
  
  character_columns <- data_base_column_types %>%
    filter(class == "character") %>%
    pull(variable)
  
  numeric_columns <- data_base_column_types %>%
    filter(class == "numeric") %>%
    pull(variable)
  
  integer_columns <- data_base_column_types %>%
    filter(class == "integer") %>%
    pull(variable)
  
  df <- df %>%
    mutate_if(names(df) %in% character_columns, as.character) %>%
    mutate_if(names(df) %in% numeric_columns, as.numeric) %>%
    mutate_if(names(df) %in% integer_columns, as.integer)
  
  return(df)
}
```

Automate database uploads - removes old data from the same year
```{r}
delete_and_upload <- function(df, year) {
  statcast_db <- db_connector()
  
  query <- paste0('DELETE from statcast where game_year = ', year)
  
  dbGetQuery(statcast_db, query)
  
  dbWriteTable(statcast_db, "statcast", df, append = TRUE)
  
  dbDisconnect(statcast_db)
  rm(statcast_db)
}
```

Manually upload 2008 to start and make sure everything's working.
```{r}
# create table and upload first year
 
payload_statcast <- annual_statcast_query(2008)
 
df <- format_append_statcast(df = payload_statcast)

delete_and_upload(df, year = 2008)
 
# connect to your database
# here I am using my personal package that has a wrapper function for this

statcast_db <- db_connector()
    
dbGetQuery(statcast_db, 'select game_year, count(game_year) from statcast group by game_year')

# disconnect from database

dbDisconnect(statcast_db)

rm(df) # remove the dataframe from memory
gc() # garbage collection
```

Map to get the rest of the years
```{r}
map(.x = seq(2009, 2019, 1),
    ~ {
      payload_statcast <- annual_statcast_query(season = .x)
      
      message(paste0('Formatting payload for ', .x, '...'))
      
      df <- format_append_statcast(df = payload_statcast)
      
      message(paste0('Deleting and uploading ', .x, ' data to database...'))
      
      delete_and_upload(df, year = .x)
      
      statcast_db <- db_connector()
      
      dbGetQuery(statcast_db,
                 'select game_year, count(game_year) from statcast group by game_year')
      
      dbDisconnect(statcast_db)
      
      message('Sleeping and collecting garbage...')
      
      
      Sys.sleep(5 * 60)
      
      gc()
    })
```

Check that the data is there
```{r}
tbl(statcast_db, 'statcast') %>%
  group_by(game_year) %>%
  count() %>%
  collect()
```

To get statcast data on a day to day basis, I made a couple functions similar to the ones above but designed to collect date for one day at a time. I run these every day using a batch script.
```{r}
daily_statcast_query <- function(date) {
  print(paste0("Collecting data for ", date))
  payload <- scrape_statcast_savant(start_date = date,
                                    end_date = date,
                                    type = 'pitcher')
  return(payload)
}

delete_and_upload_daily <- function(df, date, db_connector) {
  statcast_db <- db_connector()
  
  query <- paste0('DELETE from statcast where game_date = ', date)
  
  dbGetQuery(statcast_db, query)
  
  dbWriteTable(statcast_db, "statcast", df, append = TRUE)
  
  dbDisconnect(statcast_db)
  rm(statcast_db)
}
```

Finally, this code will get user input for the date to collect (open the console for the prompt), scrape and clean the data, and upload it to the database.
```{r}
date <- readline(prompt = "Enter date (format YYYY-MM-DD) or press enter for yesterday: ")
date <- ifelse(date == '', toString(Sys.Date() - 1), date)
d <- daily_statcast_query(date)
d <- format_append_statcast(d)
print(paste0('Uploading games from ', date, ' to database.'))
delete_and_upload_daily(d, date, db_connector)
```

Also, it's helpful to create indexes (indices?) to make queries run a bit faster. Here is the syntax for doing it in a MySQL database:
```{r}
dbGetQuery(statcast_db, "alter table statcast drop index statcast_index")

dbGetQuery(statcast_db, "alter table statcast add index statcast_index(game_date(255))")

dbGetQuery(statcast_db, "alter table statcast drop index statcast_game_year")

dbGetQuery(statcast_db, "alter table statcast add index statcast_game_year(game_year)")

dbGetQuery(statcast_db, "alter table statcast drop index statcast_type")

dbGetQuery(statcast_db, "alter table statcast add index statcast_type(type(255))")

dbGetQuery(statcast_db, "alter table statcast drop index statcast_pitcher_index")

dbGetQuery(statcast_db, "alter table statcast add index statcast_pitcher_index(pitcher)")

dbGetQuery(statcast_db, "alter table statcast drop index statcast_batter_index")

dbGetQuery(statcast_db, "alter table statcast add index statcast_batter_index(batter)")

```

Congrats now you have a Statcast database!