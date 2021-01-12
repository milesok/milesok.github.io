---
title: 'Creating a College Baseball Database, Part 1'
subtitle: Database Design!
layout: post
categories: projects ncaa-database
tags: ncaa database
published: true
---

Recently, I noticed I had an MLB database from the many data sources publicly available (Lahman, Retrosheet, Statcast, etc.) BUT for college data I just have a bunch of scripts to scrape the data. I want to get all my NCAA baseball data into a SQL database to make doing college baseball analysis easier, cleaner, and more efficient. To do this, I'm going to have to do a bunch of things, like collecting and formatting the data, analyzing it's viability and cleaning it, and creating pipelines to keep the database updated. But first, I'm going to sketch out a database design as a sort of project plan.

Basically this is just going to document my train of thought throughout this whole thing, so I'm going to try and go relatively sequentially to document what I'm doing and why. For this project, I'm going to use a relational database structure so I can use SQL to query it, and personally, I'm planning to use MySQL but this post is more conceptual than technical so that won't matter much here.

So the first thing to do when starting from scratch is figuring out what we're working from. Which is...

### A Big List of Fields
- season: what year is it (ex. 2019, 2020)
- season_id: used with team id to get the team page for a specific season
- team_id: used with season id to get the team page for a specific season
- team_name: what school the id represents
- team_abb: abbreviation code for the team
- division: what division the team is in (this could change year to year)
- conference: name of the conference the team is in (can also change year to year)
- conference_id: id for the conference as assigned by ncaa
- scoreboard_id: the id used to access the scoreboard page for a given date within the corresponding season
- player_id: ID assigned by the ncaa for each player
- player_name: Player's full name
- player_year: Player's year in school
- position: Player's primary position - this is not always accurate on the roster pages, so we might need to keep an eye on it and use starting lineups instead
- game_id: used to get play by play, box score, situational statistics
- location: name of home team school or alt location (could break off into a table for location_id, city, ballpark, if it has trackman, etc)
- away_team: id of the away team
- home_team: id of the home team
- umpire_name: home plate umpire's name
- umpire_id: created ids for each home plate umpire
- all the fields that go with the play-by-play (these will come from imported flat files so I'm gonna leave them all together)


##### Other things I might add on later
These should be relatively easy to add on later as I continue to develop the database because they should be keyed on existing fields and wouldn't require any changes to the tables we're about to create, just making new tables (or that's the goal at least).
- game logs and included variables
- full season statistics and included variables
- split statistics (same variables as full season)
- bridges between trackman, synergy, rapsodo ids
- bridges to incorporate this data into my larger baseball database to do analysis on players that go on to play professionally

### Group Fields Into Tables
- Conferences: Matches conference name (and maybe other info) to id
- DivisionsConferences: What division and conference a team is in for a given season
- Teams: Matches team name and abbreviation with ID
- PlayerTeams: What team and year in school a player is for a given season
- Players: Player biographical info (I want to find a way to include handedness too)
- Seasons: Matches ids to years
- Games: Information about each game
- Plays: From pbp scraper, information about what happened in the game
- Locations: coding in locations for where the games were played (city could give us weather, could also analyze home/away/neutral)
- Umpires: Names of umpires with generated IDs


### Identify Key Fields and Describe Relationships
I'm just gonna use a diagram for this part because it makes a heck of a lot more sense to do it visually.

<img src="https://github.com/milesok/milesok.github.io/blob/master/assets/img/ncaa-database/db_diagram_v1.PNG?raw=true" width="800">

So this is the framework I'm going to be going off of when collecting data. The next post will be about how I'm collecting the data.
