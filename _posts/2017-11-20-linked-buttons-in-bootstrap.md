---
layout: post
title: "Blasphemous Button-y Links in HTML5"
date: 2017-11-20
categories:
  - twil
---

## TWIL TL;DR
* Button elements should not contain links (or any other interactive content).
* Chrome delivers its "best guess" functionality when provided invalid HTML.
* Wrapping an anchor tag in a button-styled div creates "dead-space" in the button that does nothing when clicked.


## Invalid Button-y Links in HTML5

On my personal website I call attention to important links by styling them as buttons. As a novice in front-end programming, getting the "right look" proved somewhat challenging as I fought against some of my own CSS rules regarding opacity.

My first attempt to create button-y links resulted in the following Slim markup:

```slim
.button-styles
  a href='/projects' View Projects
```
The resulting behavior proved misleading and unintuitive. Despite the button's inviting appearance, most of the apparently clickable area seemed dead -- only specifically clicking the link text produced the desired result.

To solve this problem, I (naively) nested the anchor tag inside of a button tag.

```slim
button.button-styling
  a href='/projects' View Projects
```

Now clicking any part of the button activated the link. Huzzah! With the links working well and looking snazzy, I pushed to GitHub, deployed to Heroku, and went merrily on my way.

Weeks later, though, when demoing my site to a friend, the buttons seemed broken again. The problem appeared to be browser-dependent; the links worked in Chrome but not FireFox. A quick Google search revealed two things:

1. Nesting an anchor tag inside of a button tag is actually invalid HTML.
2. Chrome sometimes delivers its best guess for intended functionality when provided with invalid HTML.

### Interactive Content in HTML5

According to the HTML5 Content Models documentation, links and buttons both follow the models for Interactive Content. Basically, an element follows the Interactive Content Model if a user can activate it and reasonably expect something to happen. 

More importantly, though, HTML5 specifications state that browsers should follow a greedy algorithm for determining which "activation behavior" to trigger. Browsers look for the interactive element that is closest to where the user clicked, and trigger that element's behavior. If a user clicks on something that is not an interactive element -- or if the clicked element does not have an activation behavior defined -- nothing happens.

Knowing this, it becomes more clear why nesting a link inside of a button results in unintended behavior.

Here's the Slim markup again.

```slim
button.button-styling
  a href='/projects' View Projects
```

As the "closest" interactive element to itself, the user agent invokes the button's activation behavior when clicked. The outer button element effectively renders the nested link element unreachable by HTML5's activation algorithm. 

And since this particular button has no activation behavior defined, nothing happens. Alas.

Well, lesson learned! 

## What Worked in the End
It may come as no surprise that in the end, the correct markup required zero element nesting and an additional CSS rule:

```css
//SASS
a.button-styling
  opacity: $desired-opacity-setting
```
```slim
//Slim Markup
a.button-styling href='/projects' View Projects
```







