---
layout: post
title: "This Week I Learned: Blasphemous Button-y Links in HTML5"
date: 2017-11-20
tags: code html front-end
categories:
  - twil
  - software-development
---
As a practiced back-end programmer getting her feet wet in the front-end, I spent a little too much time trying to achieve the right look and feel for some button-y links on my website. The final solution proved painfully simple -- but I learned some new things about HTML5 Content Models and cross-browser behavior along the way!

## TWIL TL;DR
* FireFox is an unforgiving friend.
* Button elements should not contain links (or any other interactive content).
* Browsers can deliver their "best guess" functionality when provided invalid HTML, resulting in undefined behavior across browsers.

## Naive Markup for Button-y Links
To achieve a button-y appearance for my ever-so-important links, I nested the anchor tag inside of a button tag. You might recognize the `btn` class as a staple of the [Bootstrap front-end framework](https://getbootstrap.com/).

```html
<button class="btn">
  <a href='/projects'>View Projects</a>
</button>
```

At first this markup seemed to do the trick. But while the resulting link appeared to work in Chrome and Safari, it did not work at all in FireFox. Alas.

As it turns out, the above markup is just plain incorrect HTML.

## Incorrect Use of HTML5 Interactive Content

According to the HTML5 Content Model specifications, links and buttons both follow the models for [Interactive Content](https://www.w3.org/TR/2011/WD-html5-20110525/content-models.html#interactive-content). An element follows the Interactive Content Model if it has an "activation behavior" -- basically, if a user can click on it and reasonably expect something to happen. Makes sense.

When a user clicks on a "target" element, HTML5 specifications say that the user agent should trigger the behavior of the target or its parent element. If both the target and its parent do not have an activation behavior, then nothing happens. 

Knowing this, let's take a look at the markup again.

```html
<button class="btn">
  <a href='/projects'>View Projects</a>
</button>
```

Now we can see that the outer button element effectively renders the nested link element unreachable by HTML5's activation algorithm. Upon clicking the button, the user agent recognizes the button as a valid interactive element and correctly executes its activation behavior (a plain button [legitimately does "nothing"](https://www.w3.org/TR/2011/WD-html5-20110525/the-button-element.html#attr-button-type) by default), totally bypassing the nested link.

## But it Worked in Chrome and Safari!

Checking the offending markup against an [HTML validator](https://html5.validator.nu/) confirms its invalidity. A link may not be nested in a button, and vice versa.

This incorrect markup appears to work in Chrome and Safari because [internet browsers have the freedom to present their best guess](https://www.w3.org/MarkUp/2004/xhtml-faq#whycare) for desired behavior when presented with incorrect HTML. In this case, Chrome and Safari activate the nested link *if* the user clicks *directly* on the link text. FireFox does not. I may never have realised I was writing incorrect HTML if FireFox hadn't prevented my buttons from working as I expected them to! 

Or perhaps more fairly -- if FireFox hadn't allowed my buttons to behave exactly as they had been written...

Thanks, FireFox! Lesson learned. 

## Valid Button-y Links
It may come as no surprise that in the end, the correct markup required zero element nesting and an additional SASS rule:

```html
<a class="btn" href='/projects'>View Projects</a>
```
```sass
a.btn
  opacity: $desired-opacity-setting
```

As an added bonus, this solution makes the entire button-y area clickable! It wins on all accounts: useability, validity, and simplicity. 