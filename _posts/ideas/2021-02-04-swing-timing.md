---
published: false
subtitle: Breaking down whiffs and takes
---
### Introduction
Swings and misses, or "whiffs," have become an increasing focus for baseball analytics, especially as the practice of pitch design has become more and more ubiquitous in the baseball world. Pitch-tracking technologies like Rapsodo and Trackman have provided widespread accessibility to data that allows pitchers to connect their pitch characteristics to the probability of generating a whiff.

However, while the pitches are being dissected in more and more granular ways (for example the new seam-shifted wake research being done by Barton Smith), the swing-and-miss side of the equation is much less talked about.

A couple ideas that I've seen recently have been inspiring and encouraging that there is a lot of ground still to cover. First, Ethan Moore's piece proposing how gaining swing timing data from Hawkeye could allow for advances in the sabermetric world broke down a simple way to break down hitting into timing, bat speed, and barrel placement components, where some function of these three components would produce an outcome ranging from a whiff to weak contact to an optimal hit.

Second, in his book _Swing Kings_ Jared Diamond includes a section describing Chris Colabello's change in hitting approach, which includes this interesting nugget that I'd like to dig into from a quantitative perspective:  

> One of the best ways to predict if a slumping hitter is about to break out is to watch how he takes pitches. When they're struggling, hitters often look awkward when they take pitches, their bodies misaligned and out of balance. Being able to take a pitch comfortably and confidently means that a hitter has eliminated unnecessary movement and that his body is organized, streamlined, and athletic.  

A couple implications of this claim are that biomechanics might be a key both to more granularly evaluating hitters and to looking at hot and cold streaks, both of which are areas which have generally been assumed to be beyond us - swing biomechanics seems to currently be more about refining movement patterns than assessing reaction to a pitch, and a lot of analytical work operates with the assumption that every event is independent. While a common fallback of the sabermetric community for a long time has been that making decisions based on recent results isn't usually a wise way to manage a baseball team, there might be underlying biomechanical reasons for hot streaks and slumps that could change the way we view them. The fact is that a baseball game is a massive dynamical system where everything that happens is in fact largely interdependent, and so the more we can accurately capture the absolute fundamentals underlying the data we collect (e.g. human movement patterns), the more we can eliminate noise that propogates down the measurement chain. For the same reason that having metrics like exit velocity has allowed us to evaluate hitters more accurately and with much smaller sample sizes, understanding the way they produce those exit velocities could represent an even more reliable way to evaluate and make projections.

So anyways, back to the question. The main roadblock right now is getting the dataset to investigate these questions. How can we quantify what a batter does when thrown a pitch beyond just the binary swing take or foul/in play/whiff that we're used to? While getting kinematics data may be the ideal, in lieu of that data being publicly accessible, I think the answer to this question lies in computer vision.

### Possible Approaches
The first part of this problem is getting a dataset, as discussed above. Once we have a viable dataset, the possiblities really open up for what we could do with swing timing metrics. But any of that analysis requires a good dataset.

I think computer vision seems particularly well suited to this application. After all, that's essentially what Hawkeye will be doing, albeit on a much higher scale in terms of number of cameras, framerate, and computing power. We need to quantify the time of the swing in comparison to the time the pitch reaches the "ideal" point of contact. This in itself is an interesting problem. For a given pitch, where is the optimal point of contact for a hitter? Perhaps we could incorporate exit velocity metrics and determine that the contact is "better" given a higher exit velocity in proportion to the hitter's maximum EV.

A more nuanced problem is if we can distinguish check swings from pitches where the batter might have been "taking all the way." 

### Limitations and Potential Problems
Obviously the biggest issue here is whether a

### Data


### Methodology


### References
