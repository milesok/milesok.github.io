---
published: true
title: NCAA Play By Play Parser Introduction
subtitle: 'Or, Fun with Bad Data'
---

If you've ever visited the [NCAA Stats Portal](stats.ncaa.org) before, you know it's a very rudimentary website with not a ton of functionality. There's a _ton_ of data, but in a format that is not very easy at all to scrape and parse.

One of the first things I started on when I started working for Texas was to try and collect this data. For one, it's helpful just to have stats for opposing teams, and there is a huge amount of unexplored territory in college analytics to catch up with some of the metrics or even forge new ground that captures the [nuances of the college baseball landscape](https://milesokamoto.com/blog/2020/07/27/college-baseball-analytics-101.html).

This ended up being a classic example of the Pareto principle, aka the 80/20 rule, where with a small amount of effort, I was able to get most of the data out of the database. And there are [public examples](https://github.com/davmiller/NCAA-baseball) that are pretty similar to what I was able to get during that first season. The thing is, I wanted to get _all_ the data (a big one is to be able to build spray charts based on the tagging) and get it for _every_ game. Or at least as close as I could come within reasonable expectation. If the errors were limited to smaller schools that Texas would probably never play or that were generally inconsequential to the larger dataset it'd be one thing - but I found errors even in games with two Power 5 teams playing each other. And while yes many missing one game wouldn't dramatically move the needle for a lot of things, there was simply too much missing data at first to just be satisfied there. So I've been on and off over the past couple years trying to continue to build out and improve the program to make our database increasingly accurate.

[Here's what I've done so far](https://github.com/milesokamoto/pbpy). I'm going to just keep updating this space as I make progress, but I wanted to document a little of the process thus far just for posterity.

This project has been a huge lesson for me on how to build something. I've improved my Python skills dramatically, learned some software engineering (I think) concepts in modular code and documentation, and very importantly become really familiar with version control using git. I think the next steps could include seeing if deep learning techniques could pose a potential solution to some of the problems. At the minimum, if I'm going to be having to manually fix data, I'll want to build a simple GUI for that process.

The biggest problem that I've continually encountered in this project is that humans enter the data onto a very very old program. Because of this, something that's been a pain is that as flexible as I can make this thing, there are some cases where the website is just plain wrong, like the lineup was input incorrectly and had to be fixed later. I'm doing my best to have the program guess as best as it can within reason (based on the rules of baseball), and leave blanks and flag the game otherwise. But I just realized that it might actually just be better to just go in and change it myself for the really bad cases.
