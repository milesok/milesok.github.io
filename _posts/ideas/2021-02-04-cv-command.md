---
published: false
subtitle: How to measure pitcher intent
---
### Introduction
The idea of quantifying command is one of the more elusive objectives in baseball analytics, but one of the more important skills for pitchers. While advances in ball tracking technology have improved our ability to precisely measure the location of a pitch in space and time, as well as the attributes of the ball's spin, measuring command lags far behind the massive existing body of work on stuff.

In a 2017 article, a Baseball Prospectus article defined command as _"The ability to precisely locate pitches, in or out of the zone, with the goal of keeping each pitch out of the heart of the plate"_ and introduced their called strikes above average metric as a proxy for command.[^1] This metric effectively measures a pitcher's ability to get strikes called on the edges of the strike zone. While this is certainly a viable subsitution for a true command metric, some notable drawbacks were that it was blind to the pitcher's intent and only considered called strikes and ball. 

Another metric that I've seen publicly referenced is STATS Perform's command plus metric, which operates by having stringers manually assign each pitch a target[^2]. The issue here is the manual bit. It's not very generalizeable (say to a college or minor league baseball context) and it's proprietary.

My idea is to look into whether computer vision techniques could be used to usefully automate this target identification process and help quantify command.

### Possible Approaches


### Limitations and Potential Problems
Framerate
Contact

### Data


### Methodology


### References
[^1]: [Prospectus Feature: Command and Control](https://www.baseballprospectus.com/news/article/31022/prospectus-feature-command-and-control/)
[^2]: [The Athletic's Eno Sarris](https://theathletic.com/1646799/2020/03/04/sarris-whats-more-important-for-a-pitcher-command-or-stuff/) describes the metric here