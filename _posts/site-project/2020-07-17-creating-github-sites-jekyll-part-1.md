---
title: 'Creating a GitHub Pages Site with Jekyll, Part 1'
subtitle: A page about how this page was made
categories: projects website
layout: post
published: false
---

Jekyll is a static site generator that is integrated with GitHub Pages. That makes things pretty easy on us. It is a nice middle ground between being easy to build out of the box but fully customizable with HTML, CSS, etc.

[Here's a link](https://www.youtube.com/playlist?list=PLLAZ4kZ9dFpOPV5C5Ay0pHaa0RJFhcmcB) to the video tutorials I used to get started and to the [jekyll documentation tutorial](https://jekyllrb.com/docs/step-by-step).

### Getting Things Set Up

I started by downloading the [RubyInstaller](https://github.com/oneclick/rubyinstaller2/releases) to install the Ruby programming language on my local machine. I let it do its magic and then 

### Making the GitHub Page
This is pretty simple - just make a new repository on github with the name \<username>.github.io. I cloned the repository to my computer

### Skeleton Site
I navigated to the directory holding the cloned repository and ran ```jekyll new milesokamoto.github.io```, which creates the skeleton Jekyll site in the folder. I then pushed it all up to the repository using Git and now I have a website. We can create a local development server with ```jekyll serve``` but GitHub will automatically build the page with any updated commits you push.

## The Basics of Jekyll
### Frontmatter
Basically metadata: written in YAML or JSON
```
---
layout: post
title: "Post Title!"
date: 2020-07-17 8:55:00 -0600
categories: projects
---
```
It's useful because this data can be processed into how the website displays things, like the 'title' variable could be used by the home page to link to our post. We can [create defaults](https://jekyllrb.com/docs/configuration/front-matter-defaults/) in the \_config.yml file

### Posts!
They can be written in Markdown which makes things easy
1. Create file in \_post folder with the file name ```yyyy-mm-dd-post-title.md```
2. Always start with frontmatter: layout, title, date, etc - you can set defaults to make things easier
3. Within \_posts you can make separate directories and it doesn't mess with how Jekyll processes everything
4. We can use a \_drafts folder for unfinished stuff - ```jekyll serve --draft``` will show what the page looks like with drafts

Side note I'm using [prose.io](https://prose.io) to edit markdown and easily save changes/preview/etc. within the browser.

### Pages!
Basically anything that's not a blog. The frontmatter 'permalink' variable allows us to override the link path. We can give it a string to define the path, or a pattern (e.g. /:categories/:year/:month/:day/:title). I made a ['/now' page](https://nownownow.com/about) to test this out which is now [here](https://milesokamoto.github.io/now).

### Layouts!
This is how we'll make everything look all nice and pretty. For example, this is what our home page layout file looks like right now:
```
{% raw %}
---
layout: default
---

<div class="home">
  {%- if page.title -%}
    <h1 class="page-heading">{{ page.title }}</h1>
  {%- endif -%}

  {{ content }}

  <div class="posts-list">
    {% for post in site.posts %}
    <article class="post-preview">
      <a href="{{ post.url | relative_url }}">
        <h2 class="post-title">{{ post.title }}</h2>
     </article>
    {% endfor %}
  </div>

</div>
```
The frontmatter means all of this html is inserted into the default layout where the {{content}} {% endraw %} tag is placed. We have an if statement that will show the page title if it exists (this makes the very large "Home" at the top of the page). Then we have the content, which is everything in our `index.md` file. Finally we have a for loop that makes a link for each article in the `_posts` folder.

That's about enough for one day. I have a site now though. Pretty cool. Next time I'll spice it up with some styling and navigation!

![](https://github.com/milesokamoto/milesokamoto.github.io/blob/master/assets/img/creating-github-page/v1.PNG)

Oops not done... I went and made a [404 page](https://milesokamoto.github.io/404) too just for fun. Now I'm done.
