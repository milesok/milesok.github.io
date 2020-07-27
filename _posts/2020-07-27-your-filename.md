---
published: false
---
---
title:The New Road to Omaha
subtitle:Translating Analytics to College Baseball (2020 Edition)
published:False
---

This is an update of a talk I gave at SaberSeminar 2019 on the potential and limitations of analyzing baseball data at the NCAA D1 level.

### First Principles
Comparatively, college baseball is only just scratching the surface in terms of data-driven processes in player development, scouting, and strategy.
For this presentation, I’d like to give y’all a window inside how college baseball analytics is growing at the ncaa d1 level, talk about why college baseball is a very unique baseball environment worthy of more attention and analysis, and look ahead to what might be possible in the near future for college baseball programs looking for advantages as analytics paves a new road to Omaha.
So first, I’ll go back to where I started with laying the foundations for an analytics department at Texas. There are a number of factors that have prevented college baseball from following in the footsteps of MLB teams in committing to data-driven decision making processes: the manpower required to run a college R&D department comes virtually entirely from students willing to devote hours to baseball, with virtually no prior experience in the field. This is a blessing in that we have a lot of freedom to explore and learn about the game, but a curse in that it takes a lot of hard work and trial and error to make progress.
Second, systems like Trackman are expensive, and between video and ball-tracking technologies, some schools just don’t have the resources in their budget to install them.

On top of this, while websites like fangraphs, baseballsavant, and baseball prospectus to name a few have made it easy enough for anyone to do baseball research, for college baseball, virtually all that is publicly available is on the NCAA’s stats page, which is significantly less user-friendly than the major providers of data on pro ball.

From the start, access to large scale college baseball data has a built in barrier, requiring some coding before the data is accessible. For us at UT that meant writing programs to scrape just about everything possible from the NCAA’s stats website as well as our video provider’s API to pull charted data for games we didn’t have via the Trackman data sharing portal. 

Fortunately there are enough games in the college baseball season where we can still learn a lot from this data, but there tends to be a bias towards bigger programs in terms of what data is available.

Now, as the amount of data available to college programs increases, it becomes increasingly important to understand the nuances of the college game.
When I started out working with UT this past season, I tried calculating some fundamental things like wOBA for college baseball players. What was quickly apparent, however, was that college baseball’s setup made even approximating this with MLB weights or even a consistent weight across college baseball introduced a lot of bias into the system.

This made it clear that I needed to go back to the “First Principles” if you will of college baseball, because it seemed that many of the assumptions we were making for MLB data wouldn’t apply as simply to college ball, and we needed to create a set of guiding factors to consider for any kind of metric we’d be creating.
I’ll start with a bit of college baseball 101. In Division 1 baseball, there are 299 teams broken into 31 conferences with 6-14 teams each. These conferences vary widely in terms of competition level, schedule makeup, and style of baseball. This will be important in a minute.

We can immediately see here another major difference in college baseball, which is that the season is a lot shorter than any level of professional baseball. Division 1 teams played on average about 56 games last year, which means regular players average about 250 plate appearances over the course of the season. The average starting pitcher only throws about 80 innings.

However, we do get around 100 batted ball events at least on Trackman for each home team that has the system installed, and these become reliable *much* faster than the traditional stats If nothing else, this should tell us just how important it is to look at skill based and not results based data for college players.
Texas is in the Big 12, where every team in the conference plays every other team each season. This makes things easier, but it isn’t the case for every conference. In addition to conference games, teams schedule a few weekend series with non-conference opponents as well as regular weekday games against regional schools outside of their conference. This results in teams having control of who they play for almost half of their schedule. This has major implications for schedule strength, which, as we will see later, is a major factor in earning an NCAA tournament berth.

The goal, of course, for every team in college baseball is to make it to Omaha, and win the College World Series. This “elite 8” of teams are the quarterfinalists of a 64 team tournament, composed of 31 automatic bid conference champions, and 33 “at-large” teams chosen by a committee. Obviously, winning your conference is the surefire way to make the field of 64, but for most conferences, this champion is determined by a tournament, allowing almost every team a chance to claim the spot if they get hot at the right time.

The NCAA D1 postseason tournament is one of the defining features of college baseball, pitting the best teams from every conference against each other, and creating competition that is generally representative of Division 1 baseball as a whole. However, for most of the season leading up to Regionals, that is not the case.

One of the most basic sabermetric principles is the idea of run expectancies. These are essential in many of the foundational metrics that have become part of the advanced stat vernacular.

Here, I included a rough calculation of RE24 grids from this MLB season and this college season for comparison. Immediately, we can see that college run scoring is overall higher than MLB run scoring. (RE slide 2) However, if we break this down by conference, some conferences on the right side of the scale were very similar to the MLB run environment, while some on the left side were close to the equivalent of every game being played at Coors field. From here, we can calculate linear weights for each conference, which allow us to create metrics more representative of a player’s production relative to the conference they play in.

We can also calculate park factors that provide even more of an insight into how much variety there is in college baseball, which is similar to what is seen in minor league baseball, but with no distinctions between the levels.

It’s a natural question to ask when looking at college prospects with gaudy numbers, how was the competition that they faced? For instance, a pitcher who served as his team’s weekday starter might have faced more small-conference teams and racked up strikeouts on pitches that weekend competition teams wouldn’t swing at.

So we have two options: From a team’s perspective, during the season the most important comparisons are how players stack up against the teams they are playing in their most meaningful games, those against conference opponents. However, looking at the postseason, models need to allow for any combination of teams from different conferences.

### What is a Win?
WAR has become ubiquitous for evaluating professional baseball players, but one key assumption in using this metric is that is that each win during the regular season is equally weighted in the team’s final record, which is the most important determinant in if a team makes the playoffs. Obviously wins against division or wild card competitors have added effect of imposing a loss on the other team, but ultimately wins are still the single important number.

In college baseball this is completely different, and not all wins are of equal value. One of the more important factors for at-large selection is RPI, the Rating Percentage Index.  This system is calculated by the NCAA and attempts to rank teams based on the quality of their wins.

While this might not be the most statistically sound way to rank teams, it is the system that ultimately decides who makes the tournament and who doesn’t, and therefore we need to account for its biases.

WAR also has a problem in that a “replacement player” doesn’t really exist in college, and doesn’t have much meaning since there is no free-agent market or minor league team from which to call up a player. This means that instead of using something like WAR, we should look at some sort of weighted value above average.
With a proper foundation established about the sabermetric mechanics of college baseball, we can look ahead to using Trackman data for skill-oriented analytics. 

This would unlock the ability to measure up our players against a wider and more representative sample and take a lot of the human error and guesswork out of what we do. As more and more programs push into the frontier of data, our ability to effectively use what we do have for scouting, player development, strategy, and learning about the game will increase, and if we can build a solid foundation for how the college game works, we can push towards a future with widespread college baseball analytics because it will improve the game.
