---
published: false
---
## A New Post

### Introduction
This is an idea that started from a class project where the assignment was modeling a pattern recognition application in biomedical engineering. I chose UCL tears in baseball players, aiming to use publicly available dataset to predict whether a player would incur an injury requiring UCL reconstruction surgery.

From one estimate, Major League Baseball (MLB) teams lost over $70M in the 2019 season just from salary paid to major league players who were recovering from UCL reconstruction surgery.[^1] This figure fails to account for medical costs ($25-40k for the procedure as reported by NYTimes)[^2], losses that stem from a decrease in the team’s ability to win, and the effects of a possible impact to the player’s skill level. Injury risk is also an important factor to a player’s value, so the ability to quantify injury risk and take preventative measures is mutually beneficial for all stakeholders. For amateur baseball players, the procedure can end a player’s prospects of a professional baseball career, especially because a lost year of skill development in a player’s teenage years can stunt a player’s ability to improve, and teams’ desire to sign them.

### Strategy
While the causes of a torn UCL are still relatively unclear, trying to prevent the injury has become a major point of influence for coaches at all levels of baseball. 

There are three "levels" of analysis I could see as useful for this question:
1. 
2. "Statcast"/Trackman pitch-level data:
3. Biomechanical analysis: Given a large enough sample of kinematics data from marker-based or markerless motion capture, calculating 

### Limitations and Potential Problems


### Data

The data used in this study would be a combination of publicly available information about player statistics and injury history, and biomechanics data collected as part of the study. This would include data from an individual pitch scope (velocity, spin rate, release point, joint torques, etc.) and from a season-long scope (innings pitched, total pitches thrown per inning, total pitches thrown per game, etc.), as well as data identifying players who have required UCL reconstruction over that time span. Because this injury has been hypothesized to occur due to chronic overuse rather than in isolated events, historical data for players should be considered as well, so a player’s susceptibility to UCL injury would be conditional on inputs representing his entire career, not just a single pitch, game, or season. Therefore, the project will likely require a high amount of feature engineering prior to and concurrent with model development.


### Methodology




### References
[^1] [Sportrac MLB Injured List Tracker](https://www.spotrac.com/mlb/disabled-list/2019/cumulative-reason/)
[^2][Mets’ Harvey Is Covered Like Any Other Employee With a Workplace Injury](https://www.nytimes.com/2013/09/19/sports/baseball/harvey-is-covered-like-any-worker.html)
