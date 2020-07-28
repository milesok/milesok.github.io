---
published: true
title: 'Creating a GitHub Pages Site with Jekyll, Part 2'
subtitle: Styling Things Up
categories: projects website
date: 2020-07-28T00:00:00.000Z
layout: post
tags: jekyll webdev
---
Okay so what we have right now is a website but it's reeeeeal ugly and that's mostly cause I haven't done anything to actually style it. So I'm going to use SASS and some cool Jekyll functions to give it a bit of personality.

### Fonts and Colors
To define the styles for this webpage, I decided to use [SASS](https://sass-lang.com/). I set it up by making a folder called `_sass` in the root directory. I created a SASS stylesheet called `main.scss` with these contents:
```{sass}
$font-stack: 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif;
$primary-color: #000000;

body {
  font: 100% $font-stack;
  color: $primary-color;
}
h1 {
  font: 200% $font-stack;
  color: $primary-color;
}
```
Then we just put this into ```assets/css/styles.scss```:
```{sass}
---
---
@import "main";
```

The way that Jekyll compiles SASS, we can now add this line to the base.html to link to the generated css sheet:

```{html}
<link rel="stylesheet" href="assets/css/styles.css">
```

### Nav Bar!
Another cool feature of Jekyll is the ability to use the ```include``` tag to add code snippets. This is especially useful for something like a navigation bar or footer. I added an ```_includes``` folder and put a file called ```navigation.html``` containing code for a simple nav bar that has links for each page I put into a ```_data/navigation.yml``` file:
```{html}
<nav>
  <ul>
  {% for item in site.data.navigation %}
    <li><a href="{{ item.link }}" {% if page.url == item.link %}{% endif %}>
      {{ item.name }}
      </a></li>
  {% endfor %}
  </ul>
</nav>
```

In the YAML file, I added a couple links 
```{yaml}
- name: Home
  link: /
- name: Now
  link: /now
```

Next I added to the sass sheet to make the nav bar look nice and stand out a bit:
```{sass}
$nav-background: midnightblue;
$nav-link: white;

...

nav {
  ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    overflow:hidden;
    background-color: $nav-background;
  }
  li{
      display: inline;
      float: left;
      a {
      color: $nav-link;
      display: block;
      padding: 14px 16px;
      text-decoration: none;
      &:hover {
        background-color: steelblue;
      }
        }
  }
}
```
![](https://github.com/milesok/milesok.github.io/blob/master/assets/img/creating-github-page/v2.PNG?raw=true)
This is all fairly basic stuff but it makes a heck of a lot of difference. For the next post, I'm hoping to style up the home page and articles.