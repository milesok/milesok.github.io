---
published: false
---
---
title:NCAA Play By Play Scraper Development Journal
published:false
---

So something that's been a pain is that as flexible as I can make this thing, there are some cases where the website is just plain wrong. I'm doing my best to have the program guess as best as it can within reason, and leave blanks otherwise. But I just realized that it might not be too hard to just go in and change it myself for the reeeeeally bad cases.

I'm going to try scraping EVERYTHING and then running the parser over local files instead of having to scrape from the website from scratch each time. This way there's a chance that I could just go into the files and fix the stuff, and it'll stay that way. This would allow me to just improve the cleanliness of the data incrementally and not have to spend a ton more time on accounting for every possible discrepancy.

A couple considerations here: First I want to check out how big the files would be - maybe I scrape if it's not messed up but if there's an error it creates a data file that I can go back into and fix.