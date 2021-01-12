---
published: false
title: Scraping NCAA PbP Data
---
### The Idea
NCAA publishes game-by-game college baseball statistics on their [stats website](https://stats.ncaa.org/contests/scoreboards?utf8=%E2%9C%93&sport_code=MBA), but summary statistics are very limited, and they do not provide functionality to export play-by-play logs. The goal of this project is to create an open-source [Retrosheet](https://www.retrosheet.org/)-like database of NCAA statistics in order to do analysis. [Here](https://github.com/milesokamoto/pbpy) is the repository I'm using to build the scraper tool.

### The Process
The resources for each game include two templates that we are interested in. The first is the Box Score page, which allowed me to scrape the lineups for each game:
![]({{site.baseurl}}/files/pbp_files/box_score.png)

The Play by Play page contains a log of plays and substitutions for the game, as inputted by school SIDs. These generally follow a template based on the software used to input games, which means they are mostly standardized but are not error-free:
![]({{site.baseurl}}/files/pbp_files/pbp_log.png)

I started this project in Python, primarily using the requests library to make http requests and the lxml package to parse the responses. I started with a simple function to scrape all elements contained within table rows on a webpage, and saved it in a module called [*scrape.py*](.


### Next Steps
