---
layout: post
title: "Blog Development: Customizations"
date: 2017-10-05
categories: 
  - development
---

I used a premade Jekyll theme ([Hyde](https://github.com/poole/hyde)) to simplify development for this blog. Hyde's sticky sidebar suited my style, and the included features like "Related Posts" meant I could develop a full-featured site and still get to writing content quickly.

 Still, I couldn't resist adding a few customizations.

### Color Scheme
To achieve "brand" continuity with my personal website, I copied the reduced-opacity styles and color scheme from [www.bethanywatson.com](http://www.bethanywatson.me).

### Sidebar Responsiveness
This theme features a striking, sticky sidebar. Out of the box, its built-in reponsive behavior causes the sidebar to pop to the top of the page on smaller screen-widths. Nifty! But if you have a lot of content in the sidebar, this content can quickly overwhelm the page. 

To address this, I added a `categories` class to the "Categories" section in the sidebar and used a media query to hide this section for certain screen widths.

```css
@media (max-width: 48em) {
  .categories {
    display: none;
  }
}
``` 

And for short screens, sidebar content can get cut-off completely. I used a similar strategy to preserve the visibility of important content for shorter screen sizes. This time, I focused on `max-height`.

```css
@media (max-height: 350px) {
  .descr, .categories {
    display: none;
  }
}

@media (max-height: 500px) {
  .descr {
    display: none;
  }
}
```
The site "description" disappears first, and for even shorter screens the categories also disappear, ensuring the site navigation (and my name, heh) stay in sight as long as possible.

Go ahead and test it out!

### Post Categories
One thing the Hyde theme did not come with was built-in post categorization. I wanted to be able to categorize my blog posts according to their general topic and have a separate index page of posts for each category. 

To accomplish this, I followed [Creating Category Pages in Jekyll without Plugins](https://kylewbanks.com/blog/creating-category-pages-in-jekyll-without-plugins) by Kyle Banks. Unlike many other tutorials, Kyle uses Jekyll "collections" to create categories and category pages.

### Listing Categories in the Sidebar
In the sidebar on the left (assuming your screen is large enough!) you should see a list of categories with a post-count next to each one. Out of all the tutorials available on the web, an abridged version of [this gist](https://gist.github.com/Phlow/a0e3fa686eb259fe7f76) by Phlow ended up working for me.



