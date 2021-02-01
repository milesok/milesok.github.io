---
published: false
subtitle: A simple but very useful tool
title: Building a Live Trackman Dashboard in Google Sheets
---
Here's a quick but useful tool for college baseball managers and coaches:

The premise of this project was to simulate the HTTP request that downloads Trackman raw CSV data and use that data to live-update a dashboard. It's pretty simple, but very very useful for keeping track of what's going on in a game (a 'la baseball savant) and also for things like tracking pitch counts during scrimmages.

Here's some steps to get it up and running:
1. [Make a copy of this spreadsheet](https://docs.google.com/spreadsheets/d/1Ecy7Hu3Azx9aYUX7BIuQc_ahaCknpdSgCK_dK7qbjfE/edit?usp=sharing). You'll need the id of the new sheet in the next step.
2. [Download this code](https://gist.github.com/milesokamoto/136b0d2d801164951dad64680bc6962a) and follow the instructions in the comments at the top to fill in the necessary fields. Then just run the script and it will update your spreadsheet based on the game id value (found in the trackman url) that you put in the sheet. Use CTRL-C to stop the script when the game's over.

Here's what it should look like when it's working!
![]({{site.baseurl}}/assets/img/tm_dash/tm_dash.png)

Some notes on how this idea might be helpful:  
1. The functions to automatically download data from Trackman can save some time in generating postgame reports
2. Manipulating Google Sheets with Python is a great tool for quick, dynamic dashboards that are very accessible and quite functional for a number of tasks.