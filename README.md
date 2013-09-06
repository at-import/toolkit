# Toolkit

**Progressive Enhancement? Simple. Responsive Web Design? Done. Design in Browser? Beautiful.**

Think of Toolkit as your swiss army knife for Progressive Enhancement and Responsive Web Design. Those little bits and bobs that make your life easy and you want to reuse throughout projects but never really had a place to put? They're here, and they're designed to make your life happy. It's even got templates to get you rocking and rolling with some of the best Responsive Web Design tools Sass has to offer. Toolkit is broken out into individual pieces, so grab what you want, grab what you need, or grab the lot; the choice is yours.

## Table of Contents

1. [Border Box](#border-box)
1. [Fluid Media](#fluid-media)
   * [Fluid Images and HTML5 Video](#fluid-images-and-html5-video)
   * [Intrinsic Ratios](#intrinsic-ratios)
1. [Progressive Enhancement](#progressive-enhancement)
   * [Enhance and Degrade](#enhance-and-degrade)
   * [Progressively Enhanced Background Images](#progressively-enhanced-background-images)
   * [Progressively Enhanced Text Replacement](#progressively-enhanced-text-replacement)
1. [Clearfix](#clearfix)
1. [Vertical Center](#vertical-center)
1. [Nested Context](#nested-context)
1. [Colour Functions](#colour-functions)
	* [Tint and Shade](#tint-and-shade)
	* [Colour Stacks](#colour-stacks)
1. [Selectors](#selectors)
	* [Style Attribute](#style-attribute)
	* [Style External Links](#style-external-links)
	* [Style Internal Links](#style-internal-links)
	* [nth-child for IE7/8](#nth-child-for-ie78)
1. [Triangles](#triangles)
1. [Equal Height Columns](#equal-height-columns)
1. [Webfont Helpers](#webfont-helpers)
	* [Enable Ligatures](#enable-ligatures)
	* [Content Fade In](#content-fade-in)
1. [Viewport](#viewport)
1. [Element Queries](#element-queries)
1. [Carousels](#carousels)
	* [CSS Carousel Component](#css-carousel-component)
	* [CSS Carousel Animation](#css-carousel-animation)
1. [Debugging](#debug)
1. [Odds and Ends](#odds-and-ends)
1. [Templates](#templates)

## Requirements

Toolkit is a Compass extension, so make sure you have [Sass and Compass Installed](http://compass-style.org/install/) in order to use its awesomeness!

Toolkit also requires Sass 3.2. Toolkit should install Sass 3.2 for you when you install it, but in case you are getting errors, open up your terminal and type the following in:

`gem install sass`

This will install Sass 3.2. If you are compiling with CodeKit, [Chris Coyier has an awesome writeup](http://css-tricks.com/media-queries-sass-3-2-and-codekit/) on how to get CodeKit playing nice with Sass 3.2, at least until it is updated to 3.2.

## Installation

`gem install toolkit`

#### If creating a new project
`compass create <my_project> -r toolkit`

#### If adding to existing project, in config.rb
`require 'toolkit'`

#### Import the toolkit partial at the top of your working file
`@import "toolkit";`


## Border Box

The traditional box model is boring and annoying. I set my width to be 15%, but then my padding and my borders push that out even wider, making my life on a grid oh so hard and oh so annoying. I wish there was a way to keep everything within my set width.

Well look no further! Now there is! Introducing the Natural Box Layout Model, also knows as Border Box box sizing! Paul Irish [proposed using box sizing this way](http://paulirish.com/2012/box-sizing-border-box-ftw/) on all of our elements to get that warm, fuzzy feeling. Simply import this partial, and you'll be happy as a clam. This will add the following snippet to your code:

```scss
* { @include box-sizing('border-box'); }
```

## Fluid Media

Before I go any further, I must say the following.

Sass will not magically give you responsive media. Neither will Compass, Modernizr, or any CSS or JavaScript Framework. For responsive media to be a reality, we need a new browser based standard. There currently is the [proposed `<picture>` element](https://dvcs.w3.org/hg/html-proposals/raw-file/9443de7ff65f/responsive-images/responsive-images.html) over at the World Wide Web Consortium, and there's  [a proposed `srcset` attribute on current image elements](http://www.whatwg.org/specs/web-apps/current-work/multipage/embedded-content-1.html#attr-img-srcset) over at the Web Hypertext Application Technology Working Group, but until there is a standard, everything is a hack.

With that being said, there are some tricks you can do in CSS to make media fluid, and Sass rocks at this.

### Fluid Images and HTML5 Video

This is the most basic of fluid media solutions: take an image or HTML5 video, make sure you never make it larger than it natively is, and scale it to fit its holder when the holder gets small. Keep everything in proportion. This will add the following snippet to your code:

```scss
img, video {
  max-width: 100%;
  height: auto;
}
```

### Intrinsic Ratios

What is an intrinsic ratio you may ask? Well Thierry Koblentz wrote a great [A List Apart article](http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/) explaining it all in great detail; go read it. In a nutshell, however, it's a way to force any child elements to fluidly scale at a given ratio, including videos and frames, making awesome responsive happiness. Provided is a `intrinsic-ratio` mixin (or, the shorter `ir` mixin) that takes three inputs: `$ratio` which defaults to `16/9` for the ratio you want to use, `$width` which defaults to `100%` for what percentage of the parent width you want the scaled elements to take up, and `$elements` which defaults to `*` for what child elements you want this to apply to. By default, the mixin will try and optimize your output as much as possible and group pieces of the output together to provide smaller CSS output, but if you set `$extend: false` as a parameter of the mixin call, it won't. You can also choose whether or not you'd like your confined element to be at the top or bottom of their parent element by setting `$direction: top` or `$direction: bottom`. An example of how you can use intrinsic ratios:

```scss
.ratio-16-9 {
  @include intrinsic-ratio;
}

.ratio-4-3-75 {
  @include intrinsic-ratio(4/3, 75%);
}

.ratio-7-8-75-iframe-no-extend {
  @include intrinsic-ratio(7/8, 75%, 'iframe', false);
}
```
```css
.ratio-16-9, .ratio-4-3-75 {
  position: relative;
  height: 0;
}

.ratio-16-9 > *, .ratio-4-3-75 > * {
  display: block;
  position: absolute;
  width: 100% !important;
  height: 100% !important;
  top: 0;
  margin: 0;
  padding: 0;
}

.ratio-16-9 {
  padding-top: 56.25%;
  width: 100%;
}

.ratio-4-3-75 {
  padding-top: 56.25%;
  width: 75%;
}

.ratio-7-8-75-iframe-no-extend {
  position: relative;
  height: 0;
  padding-top: 85.71429%;
  width: 75%;
}
.ratio-7-8-75-iframe-no-extend > iframe {
  display: block;
  position: absolute;
  width: 100% !important;
  height: 100% !important;
  top: 0;
  margin: 0;
  padding: 0;
}
```

You can also set the defaults you'd like to use for all intrinsic ratio calls by setting a few variables. Their defaults are shown, but you can set them to whatever you'd like before you use the `intrinsic-ratio` mixin and those'll be used.

```scss
$intrinsic-ratio: 16/9;
$intrinsic-ratio-width: 100%;
$intrinsic-ratio-elements: '*';
$intrinsic-ratio-extend: true;
$intrinsic-ratio-direction: top;
```

If you are looking to just change the ratio or the width of an item you've already used the `intrinsic-ratio` mixin with, you can call the `intrinsic-ratio-ratio` mixin with arguments `$ratio`, `$width`, and `$direction` on the element you've already applied the `intrinsic-ratio` mixin to. This will change the ratio the previously defined child elements adhere to.

## Progressive Enhancement

The crux around which all of the Progressive Enhancement tools are built is [Modernizr](http://modernizr.com) style CSS classes for CSS hooks. In fact, I highly suggest you to go download a custom build of Modernizr and use it in every one of your projects. That being said, mixin love for all!

### Enhance and Degrade

There are two mixins that go side by side to enhance and degrade your CSS: `enhance-with` and `degrade-from`. Now, these don't' magically provide you with your enhancements or depredations, but they do magically add in all of the proper classing for you, and more importantly, provides an easy to read mental model for what you're doing. The key here is that what you put in is what you get out, so if you're looking to enhance with Modernizr's CSS3 Transforms CSS hook, for instance, you'd call `@include enhance-with(csstransforms){}`. The degradation mixin also assume that your degraded style is also a No JavaScript style unless you pass in `$no-js: false` as well. A little example as to how you use them.

```scss
#foo {
  @include enhance-with(touch) {
    height: 44px;
    width: 44px;
  }
  @include degrade-from(touch) {
    height: 20px;
    width: 50px;
  }
}
```
```css
.touch #foo {
  height: 44px;
  width: 44px;
}
.no-touch #foo, .no-js #foo {
  height: 20px;
  width: 50px;
}
```

### Progressively Enhanced Background Images

You would think that background images are tried and true, and you would be wrong! How about SVG background images with PNG Fallbacks? How about Retina with standard fallbacks? There are two mixins that exist that will allow you to use progressive enhancement techniques to create your background, including optimizations like spriting your images and inlining your SVG. Below are the two background mixins.

#### SVG Background

The SVG Background mixin is a nifty little piece of code that takes Modernizr SVG feature detection and creates sweet sweet background images with it. The folder setup is super easy; create a folder in your Images directory, name it something descriptive (I'm going to do *social* for a handful of social images), and stick in that folder both your SVG and your PNG files. Each SVG file should have a matching PNG file that is named the same except for the file extension, so *flag.svg* should have a matching *flag.png*.

The code itself is pretty easy. Simply make a variable set to what the folder name in your Images directory (if it's in a sub-directory, include the full path from your Images directory in front of the name of the folder), include the sprite map generator mixin passing in that variable, then include the svg background mixin with the variable and the name of the file you want to use! Couldn't be simpler.

```scss
$social: 'social';
@include sprite-map-generator($social);

#flag {
  @include svg-background($social, 'flag');
}

#code {
  @include svg-background($social, 'code');
}
```
```css
.no-svg #flag, .no-js #flag, .no-svg #code, .no-js #code {
  background-image: url('/images/social-sbba688537b.png');
  background-repeat: no-repeat;
}

#flag {
  width: 72px;
  height: 72px;
}
.svg #flag {
  background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBB…mc+DQo=');
  background-repeat: no-repeat;
  background-size: 72px 72px;
}
.no-svg #flag, .no-js #flag {
  background-position: 0 -144px;
}

#code {
  width: 72px;
  height: 72px;
}
.svg #code {
  background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9y…C9zdmc+DQo=');
  background-repeat: no-repeat;
  background-size: 72px 72px;
}
.no-svg #code, .no-js #code {
  background-position: 0 0;
}
```

There are a few options you can pass into `svg-background` to have more control over the output. If you would prefer to link to your SVG files instead of inlining them, include the parameter `$inline-svg: false`. If you don't want to include the dimensions, pass `$with-dimensions: false` into the mixin.

#### Retina Background

The Retina Background mixin has pretty much the identical Sass with just slightly different folder setups. Instead of putting both the retina and standard images in the same folder, you create two folders with identical names, the retina one being appended with *_2x*, and have a standard version in your regular folder and the double sized one in the *_2x* folder (both with the same names). For instance, if we're using those social images again, we'd have a folder *social* and a folder *social_2x*. We then make image sprites for your images to reduce HTTP requests, and all is awesome.

Now, there are some intracacies in with dealing with the asset downloading and media queries needed for this. The approach I've taken is a combination of the best practices I've come to use, but may not suit all of your needs. This, unfortunately, is the nature of Retina images and asset downloading at the moment. The output you're going to get is the standard size image plus sprite for when an IE6, IE7, or IE8 body class exists following the best practice in HTML5 Boilerplate. You are going to get the standard size image for a DPR less than 1.5 and the retina image at a DRP greater than or equal to 1.5. The media queries generated take into account Webkit, old Mozilla, experimental Opera, CSSWG Standard (which I have issues with, but it's the standard so it's included) and standard Resolution fallback which isn't as reliable as one may like due to CSS Resolution, but it's the only fallback we've got.

The code itself is pretty easy. Simply make a variable set to what the standard image size folder is named in your Images directory, include the sprite map generator mixin passing in that variable, then include the retina background mixin with the variable and the name of the file you want to use! Couldn't be simpler.

```scss
$social: 'social';
@include sprite-map-generator($social, 'retina');

#flag {
  @include retina-background($social, 'flag');
}

#code {
  @include retina-background($social, 'code');
}
```
```css
.ie6 #flag, .ie7 #flag, .ie8 #flag, .ie6 #code, .ie7 #code, .ie8 #code {
  background-image: url('/images/social-sbba688537b.png');
  background-repeat: no-repeat;
}

#flag {
  width: 72px;
  height: 72px;
}
.ie6 #flag, .ie7 #flag, .ie8 #flag {
  background-position: 0 -144px;
}
@media (-webkit-max-device-pixel-ratio: 1.4), (max--moz-device-pixel-ratio: 1.4), (-o-max-device-pixel-ratio: 7 / 5), (min-resolution: 1.4dppx), (min-resolution: 134.4dpi) {
  #flag {
    background-image: url('/images/social-sbba688537b.png');
    background-repeat: no-repeat;
    background-position: 0 -144px;
  }
}
@media (-webkit-max-device-pixel-ratio: 1.5), (max--moz-device-pixel-ratio: 1.5), (-o-max-device-pixel-ratio: 3 / 2), (min-resolution: 1.5dppx), (min-resolution: 144dpi) {
  #flag {
    background-image: url('/images/social_2x-s2b6e61b993.png');
    background-repeat: no-repeat;
    background-size: 72px 72px;
    background-position: 0 -288px;
  }
}

#code {
  width: 72px;
  height: 72px;
}
.ie6 #code, .ie7 #code, .ie8 #code {
  background-position: 0 0;
}
@media (-webkit-max-device-pixel-ratio: 1.4), (max--moz-device-pixel-ratio: 1.4), (-o-max-device-pixel-ratio: 7 / 5), (min-resolution: 1.4dppx), (min-resolution: 134.4dpi) {
  #code {
    background-image: url('/images/social-sbba688537b.png');
    background-repeat: no-repeat;
    background-position: 0 0;
  }
}
@media (-webkit-max-device-pixel-ratio: 1.5), (max--moz-device-pixel-ratio: 1.5), (-o-max-device-pixel-ratio: 3 / 2), (min-resolution: 1.5dppx), (min-resolution: 144dpi) {
  #code {
    background-image: url('/images/social_2x-s2b6e61b993.png');
    background-repeat: no-repeat;
    background-size: 72px 72px;
    background-position: 0 -144px;
  }
}
```

If you do not want to include dimensions in your output, pass `$with-dimensions: false` into the `retina-background` mixin as well.

### Progressively Enhanced Text Replacement

Text replacement is pretty good for accessibility and whatnot, but as is, it's not very good for progressive enhancement. There's a lot that goes in to text replacement in general, and then combine that with serving either a PNG or an SVG (for resolution independence) and you start to have to write a lot of CSS for something fairly simple. Plus, we all like to use image sprites for our text replacement, right? RIGHT?! That's even more work that we need to deal with. Not any more! We can have Compass automate the whole process, and do it more efficiently than if we had done it by hand to boot. Setup is fairly easy, and there is only one major restriction: this method cannot currently be used from within a media query, but other than that, it's good to go!

#### The Setup

There are two ways you can use the Progressively Enhanced Text Replacement; either with SVG (the default, preferred way) or with Retina images.

**The SVG Way:** In you Images directory, create a directory to hold the images you want sprited together. All of the images must be in .png format. In that same directory, place the SVG files you want to use. Each .png file you want to use should have a corresponding .svg file with the same name. I'm going to create some social images, so I'm going to put them inside a social folder.

**The Retina Image Way:** In your Images directory, create a directory to hold the images you want sprited together, and another named the same appended with *_2x* to hold your retina images. All of the images must be in .png format. Each single sized images should have a corresponding retina image of the same name. I'm going to create some social images, so I'm going to put them inside a social folder.

#### The Usage

Very easy. Make a variable set to what the folder name is inside your Images directory, or the standard image size folder name for retina, include the sprite map generator mixin passing in that variable, then include the progressive replace text mixin with the variable and the name of the file you want to use! Couldn't be simpler.

** The SVG Way**
```scss
$social: 'social';
@include sprite-map-generator($social);

#flag {
  @include replace-text-pe($social, 'flag');
}

#code {
  @include replace-text-pe($social, 'code');
}
```

** The Retina Image Way**
```scss
$social: 'social';
@include sprite-map-generator($social, 'retina');

#flag {
  @include replace-text-pe($social, 'flag', 'retina');
}

#code {
  @include replace-text-pe($social, 'code', 'retina');
}
```

#### The SVG Output

By default, the progressive text replacement mixin will do a few things: it will inline your SVG to reduce HTTP requests and cache them with your CSS, it will include dimensions for your output, and it assumes that what you're replacing isn't an inline element. If you'd like to change this, pass the following into your `replace-text-pe` mixin call: `$inline-svg: false` for linked SVG images, `$with-dimensions: false` for no dimensions, and `$inline-element: true` for an inline element.

The mixin does a lot of optimization to try and ensure the minimal amount of code is printed out, and assumes that if there is no JavaScript present, that it is to use the image sprite that it creates.

```bash
created images/social-sbba688537b.png
```

```css
#flag, #code {
  text-indent: 110%;
  white-space: nowrap;
  overflow: hidden;
}

.no-svg #flag, .no-js #flag, .no-svg #code, .no-js #code {
  background-image: url('/images/social-sbba688537b.png');
  background-repeat: no-repeat;
}

#flag {
  width: 72px;
  height: 72px;
}
.svg #flag {
  background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAt…+DQo=');
  background-repeat: no-repeat;
  background-size: 72px 72px;
}
.no-svg #flag, .no-js #flag {
  background-position: 0 -144px;
}

#code {
  width: 72px;
  height: 72px;
}
.svg #code {
  background-image: url('data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjAsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAt…+DQo=');
  background-repeat: no-repeat;
  background-size: 72px 72px;
}
.no-svg #code, .no-js #code {
  background-position: 0 0;
}
```
#### The Retina Image Output

Due to an outstanding edge case in Sass which is informed by a design decision on the part of the creators of Sass, the Retina output isn't as elegant a solution as the SVG solution. Whereas the SVG solution will `@extend` the background image calls so it's only written once, making that output nice and DRY, the Retina output needs to write the background image to each selector. Fortunately, it's the same image call for retina and non-retina devices, so you'll only get one download.

Now, there are some intracacies in with dealing with the asset downloading and media queries needed for this. The approach I've taken is a combination of the best practices I've come to use, but may not suit all of your needs. This, unfortunately, is the nature of Retina images and asset downloading at the moment. The output you're going to get is the standard size image plus sprite for when an IE6, IE7, or IE8 body class exists following the best practice in HTML5 Boilerplate. You are going to get the standard size image for a DPR less than 1.5 and the retina image at a DRP greater than or equal to 1.5. The media queries generated take into account Webkit, old Mozilla, experimental Opera, CSSWG Standard (which I have issues with, but it's the standard so it's included) and standard Resolution fallback which isn't as reliable as one may like due to CSS Resolution, but it's the only fallback we've got. Like with SVG output, it assumes that you're going to want to include your dimensions and that your elements aren't inline. If you'd like to change that, set `$with-dimensions: false` for no dimensions and `$inline-element: true` for an inline element.

```scss
#flag, #code {
  text-indent: 110%;
  white-space: nowrap;
  overflow: hidden;
}

.ie6 #flag, .ie7 #flag, .ie8 #flag, .ie6 #code, .ie7 #code, .ie8 #code {
  background-image: url('/images/social-sbba688537b.png');
  background-repeat: no-repeat;
}

#flag {
  width: 72px;
  height: 72px;
}
.ie6 #flag, .ie7 #flag, .ie8 #flag {
  background-position: 0 -144px;
}
@media (-webkit-max-device-pixel-ratio: 1.4), (max--moz-device-pixel-ratio: 1.4), (-o-max-device-pixel-ratio: 7 / 5), (min-resolution: 1.4dppx), (min-resolution: 134.4dpi) {
  #flag {
    background-image: url('/images/social-sbba688537b.png');
    background-repeat: no-repeat;
    background-position: 0 -144px;
  }
}
@media (-webkit-max-device-pixel-ratio: 1.5), (max--moz-device-pixel-ratio: 1.5), (-o-max-device-pixel-ratio: 3 / 2), (min-resolution: 1.5dppx), (min-resolution: 144dpi) {
  #flag {
    background-image: url('/images/social_2x-s2b6e61b993.png');
    background-repeat: no-repeat;
    background-size: 72px 72px;
    background-position: 0 -288px;
  }
}

#code {
  width: 72px;
  height: 72px;
}
.ie6 #code, .ie7 #code, .ie8 #code {
  background-position: 0 0;
}
@media (-webkit-max-device-pixel-ratio: 1.4), (max--moz-device-pixel-ratio: 1.4), (-o-max-device-pixel-ratio: 7 / 5), (min-resolution: 1.4dppx), (min-resolution: 134.4dpi) {
  #code {
    background-image: url('/images/social-sbba688537b.png');
    background-repeat: no-repeat;
    background-position: 0 0;
  }
}
@media (-webkit-max-device-pixel-ratio: 1.5), (max--moz-device-pixel-ratio: 1.5), (-o-max-device-pixel-ratio: 3 / 2), (min-resolution: 1.5dppx), (min-resolution: 144dpi) {
  #code {
    background-image: url('/images/social_2x-s2b6e61b993.png');
    background-repeat: no-repeat;
    background-size: 72px 72px;
    background-position: 0 -144px;
  }
}
```

#### Global Defaults

If you'd like to set some global defaults to choose how this mixin works across your stylesheets, there are some defaults you can set. Their defaults are shown, but you can set them to whatever you'd like before you use the `replace-text-pe` mixin and those'll be used.

```scss
$replace-text-pe-method: 'svg';
$replace-text-pe-inline-svg: true;
$replace-text-pe-with-dimensions: true;
$replace-text-inline-element: false;
```

## Clearfix

Everyone loves a clearfix, and we've got three for you. A [Legacy Clearfix](http://www.css-101.org/articles/clearfix/latest-new-clearfix-so-far.php) for when you need ALL the support, the [Micro Clearfix](http://nicolasgallagher.com/better-float-containment-in-ie/) for when you need old Internet Explorer support but don't care about old FireFox support, and a new hot [Modern Clearfix](http://www.css-101.org/articles/clearfix/latest-new-clearfix-so-far.php) that goes especially well with Border Box. Using them is as simple as extending them:

```scss
#legacy {
  @extend %clearfix-legacy;
}

#micro {
  @extend %clearfix-micro;
}

#modern {
  @extend %clearfix;
}
```
```css
#legacy {
  /* for IE 6/7 */
  *zoom: expression(this.runtimeStyle.zoom="1", this.appendChild(document.createElement("br")).style.cssText="clear:both;font:0/0 serif");
  /* non-JS fallback */
  *zoom: 1;
}
#legacy:before, #legacy:after {
  content: ".";
  display: block;
  height: 0;
  overflow: hidden;
}
#legacy:after {
  clear: both;
}

#micro {
  /* for IE 6/7 */
  *zoom: expression(this.runtimeStyle.zoom="1", this.appendChild(document.createElement("br")).style.cssText="clear:both;font:0/0 serif");
  /* non-JS fallback */
  *zoom: 1;
}
#micro:before, #micro:after {
  content: "";
  display: table;
}
#micro:after {
  clear: both;
}

#modern:after {
  content: "";
  display: table;
  clear: both;
}
```

If you don't know which one you need to use, or you want to use them super quickly without thinking, you can simply `@include clearfix;` wherever you'd like to. The mixin takes an optional argument, `$extend`, which defaults to false, but if set to true, will extend the extendables above for you.

Like Intrinsic Ratios and the Progressively Enhanced Text Replacement mixins, there are a handful of default variables you can change that will determine what code to use. The defaults are shown, but you can set them to whatever you'd like before you use the `clearfix` mixin and those'll be used.

```scss
$clearfix-extend: false;
$legacy-support-for-ie6: true;
$legacy-support-for-ie7: true;
$legacy-support-for-mozilla: true;
```



## Vertical Center

Vertical centering doesn't exist in CSS. If your designers do it, they're mean. Simple as that. That being said, our designers *do* do it and our clients *do* want it, so we need to provide it. The vertical centering trick comes from [CSS Tricks](http://css-tricks.com/vertically-center-multi-lined-text/) and has been adapted to allow for inclusion of legacy Internet Explorer through Compass's default `$legacy-support-for-ie` variable. It comes in two forms, a mixin and an extendable. The output is shown with the legacy support.

```scss
#vertical {
  @include vertical-center;
}
// or
#vertical {
  @extend %vertical-center;
}
```

```css
#vertical {
  display: table-cell;
  vertical-align: middle;
  margin-top: inherit;
  *clear: expression(style.marginTop = "" + (offsetHeight < parentNode.offsetHeight ? parseInt((parentNode.offsetHeight - offsetHeight) / 2) + "px" : "0"),     style.clear = "none", 0     );
}
```

## Nested Context

Sometimes we may be inside of an element but need somthing the width of its parent.

![Basic nested context](http://img.pgdn.us/nested-context.png)

This is easy with fixed widths because then we can just make the child the width we want it but percentages change with each new context. With just a little bit of math we can pretty easily figure out what context we are in and it is condensed in the `nested-context()` function. Simply write how wide your current container is and it will figure out how wide it’s parent is like `nested-context(30%)` will give you a percentage to match the parent. Sometimes you are multiple levels deep and in that case, you can just list the levels `nested-context(80% 60% 33%)` and result in a percentage matching that of the 3rd parent up.

To make things a little easier, there is also a mixin that writes the width for you:

<div data-height="239" data-theme-id="0" data-slug-hash="vGuaI" data-user="scottkellum" data-default-tab="css" class='codepen'><pre><code>.container {
  width: 33%;
  background-color: red;
  height: 1em; padding: 1em 0;
}

.child {
  @include nested-context(33%);
  background-color: blue;
  height: 1em;
}</code></pre>
<p>See the Pen <a href='http://codepen.io/scottkellum/pen/vGuaI'>Nested Context</a> on <a href='http://codepen.io'>CodePen</a></p>
</div><script async src="http://codepen.io/assets/embed/ei.js"></script>

If what you are nesting is centered or left aligned, it has key words like `center` and `left` that help position the child so that it matches the parent:

<div data-height="268" data-theme-id="330" data-slug-hash="mwlGe" data-user="scottkellum" data-default-tab="css" class='codepen'><pre><code>.container {
  width: 33%;
  margin: 0 auto;
  background-color: red;
  height: 1em; padding: 1em 0;
}

.child {
  @include nested-context(33%, center);
  background-color: blue;
  height: 1em;
}</code></pre>
<p>See the Pen <a href='http://codepen.io/scottkellum/pen/mwlGe'>Centered nested context</a> on <a href='http://codepen.io'>CodePen</a></p>
</div><script async src="http://codepen.io/assets/embed/ei.js"></script>

## Colour Functions

While Sass comes with lots of of great colour functions, there are a few missing ones, and a few that I've found particularly useful, that have been added.

### Tint and Shade

While Sass's built in `lighten` and `darken` functions are great if you're looking not to change the base colour, they aren't what designers think of when they think of lightening or darkening a colour. The mental model for those is actually mixing white or black to lighten or darken a colour. So, like so many others, we have a `tint` and `shade` function that will do just that. Simply pass the colour and the amount you want. For instance, if you wanted a red that was 25% lighter or darker than the standard CSS red, you'd do one of the followings:

```scss
$red: tint(red, 25%);
// -or-
$red: shade(red, 25%);
```

### Colour Stacks

One technique for working with colour that I find very useful is to create colour stacks that get either lighter or darker as they go, allowing me to easily create full colour pallets with only a handful of base colours and then only needing to remember those base colours. I call these colour stacks, and making them with Toolkit is super easy. A sample colour stack, if written by hand, may look something like the following:

```scss
$red: red, #ff3f3f, #ff7f7f, #ffbfbf, #ffd8d8, #fff2f2;
```

This is a colour stack for red that gets tinted as I go (25%, 50%, 75%, 85%, 90%). To make figuring these out easier, there is the `colour-stack` function that takes two required parameters, the main colour you want to use and the secondary colour you want to use (in the case of shading red, the main colour would be red and the secondary colour would be black), and a variable number of arguments of what percent you want them mixed. For instance, if you wanted to mix red as your main colour with blue as your secondary colour and want a 25%, 50%, 75%, 100% mix, you would do the following:

```scss
$red-blue: colour-stack(red, blue, 25%, 50%, 75%, 100%);
```

The equivalent hand written stack would be:

```scss
$red-blue: red, #bf003f, #7f007f, #3f00bf, blue;
```
While main colour and secondary colour are always required, the amounts are not. The default mixing percentages are `25%, 50%, 75%, 85%, 90%` which can be changed by setting the global `$colour-stack-amounts`.

If you are looking to mix two colours together in equal amount, you can instead use the the `colour-scale` function which also takes a main and secondary colour as well as a total number of shades you would like. This will return a colour stack going evenly from the main colour to the secondary colour over the given number of shades.

Finally, because the two most common use cases I've found for colour stacks are stacks of tints or shades, there are the `tint-stack` and `shade-stack` functions. They take in your primary colour and an optional set of amounts (just like the `colour-stack` function) and will return the tint or shade equivalents for `colour-stack`. So, if we take our original example of a colour stack, that can now be rewritten as:

```scss
$red: tint-stack(red);
```

All colour functions and variables are available in both the English spelling (colour) and the American spelling (color).

## Selectors

One of the most powerful and least used ways of selecting in CSS are Attribute Selectors. These nifty little things allow you to dive into the attributes of an item and style based on what you find. Want all of your Twitter links to have a little bird to the left without needing to deal with special classes or JavaScript? Easy as pie with CSS Attribute Selectors. Chris Coyier has a [great writeup on Attribute Selectors](http://css-tricks.com/attribute-selectors/) that will give you a fairly extensive overview of what they can do.

### Style Attribute

For most of the attribute selections you're going to want to do, you are only going to need a single attribute selector. There is now a `style-attribute` mixing that allows you to easily style based on an attribute. The mixin takes three required variables, `$attribute` for the attribute you're querying (such as `href` or `rel`), `$selector` for how you want to select which accepts 'equals', 'contains', 'begins with', 'ends with', 'within spaced list', and 'within dashed list', and `$value` for the value you want to query. There is a fourth optional selector, `$sibling`, for if you want to attach the query to a sibling, such as a tag or a class. If you don't include a sibling, just the attribute selector will be written. For instance, the first example Chris has written, `h2[rel="friend"] {}` could be rewritten as follows:

```scss
@include style-attribute('rel', 'equals', 'friend', 'h2') {
  // Styles Go Here;
}
```

### Style External Links

One of the most common uses for attribute selectors is to style links. The `style-external-links` mixin is here to help! This mixing takes two optional input variables, `$base-url` which is a protocol neutral URL (so 'twitter.com' instead of 'http://www.twitter.com'), and `$scheme` with available options of 'plain' for plain URLS (http://), 'secure' for secure URLs (https://), and 'all' for all urls (http:// and https://) which defaults to 'all'. If you choose not to pass in a `$base-url`, you will style all external links. If you do pass in a `$base-url`, you will only style links to that site.

**Please Note:** The method for doing styling external links in general relies upon the assumption that your internal links do not have absolute paths (*i.e.* they are something like `/about.html` instead of `http://foo.com/about.html`). If your internal links have absolute paths, they will pick up styling meant for only external URLs. If this is potentially an issue you use this mixin with your site's protocol relative URL (`foo.com` instead of `http://foo.com`) to override this behavior.

As an example, let's say we wanted all Twitter links to be blue and have a little Twitter bird next to them. We can write the following:

```scss
@include style-external-links('twitter.com') {
  color: blue;
  
  &:before {
    content: '';
    height: 1em;
    width: 1em;
    display: inline-block;
    background-image: image-url('twitter.svg');
    background-size: 100%;
  }
}
```

This would wind up becoming:

```css
a[href^="http://twitter.com"],
a[href^="http://www.twitter.com"],
a[href^="https://twitter.com"],
a[href^="https://www.twitter.com"] {
  color: blue;
}

a[href^="http://twitter.com"]:before,
a[href^="http://www.twitter.com"]:before,
a[href^="https://twitter.com"]:before,
a[href^="https://www.twitter.com"]:before {
  content: '';
  height: 1em;
  width: 1em;
  display: inline-block;
  background-image: image-url('twitter.svg');
  background-size: 100%;
}
```

### Style Internal Links

Sometimes, you want to style all of your internal links differently than your external links a certain way. That's where `style-internal-links` comes in! The selector it uses to determine internal links will only work with relative URLs and requires CSS3 (with a fallback for just `a` tags of Legacy IE support is needed), but it will work wonders for them. If you need to style internal links with absolute paths, see the note in [Style External Links](#style-external-links). Usage is super simple:

```scss
@mixin style-internal-links {
  color: red;
}
```

```css
/* If $legacy-support-for-ie: true; */
a {
  color: red;
}
/* Always */
a:not([href^='http://']),
a:not([href^='https://']) {
  color: red;
}
```

### nth-child for IE7/8

Nth-child is annoyingly not supported by Internet Explorer 8 and below. But Internet Explorer 7 and 8 support *other* selecors that can be used to the same effect as nth-child. Children of IE is intended to mimic as much nth-child functionality as possible in IE 7 and 8.

Use :nth-child() functions as you normall would but instead wrap nth-child() in escaping characters like so:

```scss
p:nth-child(3)      {} // normal nth-child
p#{nth-child(3)}    {} // children-of-ie nth-child
```

n+ strings are supported as well.

```scss
p:nth-child(n+3)    {} // normal nth-child
p#{nth-child(n+3)}  {} // children-of-ie nth-child
```

Works just fine without a selector.

```scss
:nth-child(2)       {} // normal nth-child
#{nth-child(2)}     {} // children-of-ie nth-child
```

Other strings are NOT supported.

```scss
p#{nth-child(3n)}   {} // STRING NOT SUPPORTED
p#{nth-child(odd)}  {} // STRING NOT SUPPORTED
p#{nth-child(6n+4)} {} // STRING NOT SUPPORTED
```


###### This funciton was inspired by:

http://abouthalf.com/2011/07/06/poor-mans-nth-child-selector-for-ie-7-and-8/

## Triangles

You love em! Triangles! Now create them using just CSS! Turn any element or pseudo element into a triangle buy just using the `@include triangle;`. It’s perfect for flags, speech bubbles, and arrows.

You can pass through arguments like color, height, and width as well as set the offset angle from 0° to 360°.

```scss
triangle($color, $height, $width, $angle)
```

Width and height just stretch the triangle to match a width or height. You can use any units you want although percentages don’t work so well.

Angle is where the  point of the triangle is drawn opposing one side. This is a little diffucult to explain, so here is a gif.

![triangle](http://img.pgdn.us/triangle2.gif)

If the width and height are not uniform, then the angle will be stretched to match the triangles proportions.

#### Output example:

```scss
.triangle {
  @include triangle(#09f, 40px, 100px, 150);
}
```

```css
.triangle {
  display: block;
  width: 0;
  height: 0;
  border: 0 solid transparent;
  border-bottom-color: #0099ff;
  border-width: 40px 16.66667px 0 83.33333px;
}
```

![triangle example](http://img.pgdn.us/triangle-ex.png)

#### But this angle thing is confusing!

*new in 1.2.2:* Yeah, it is hard to visualize so the mixin also supports keywords like `top`, `top right`, `right` and so on. The triangle will point in the direction you give it.

```scss
@include triangle($angle: top right);
```

## Equal Height Columns

Remember the good-old-fashioned [Faux Columns Hack](http://alistapart.com/article/fauxcolumns) for creating equal height columns? If not, it's pretty ingenious; you create a horizontal strip of your background, then have it `repeat-y` on a wrapper of your columns. The issue with this method, of course, is it doesn't work well for fluid designs. Worry not thought! Using the magic of CSS Gradients, you can now do the same thing fluidly and in pure CSS! The `equal-height-columns` mixin is here to save the day! Simply pass a list of widths and a list of colors and it'll build out your equal height columns for you!

```scss
.col-1 {
  width: 25%;
  float: left;
 }
 .col-2 {
   width: 50%;
   float: left;
 }
 .col-3 {
   width: 25%;
   float: right
 }
 
 .col-wrapper {
   // Widths are where each color band should end, so with the above columns, they're going to end at 25%, 75%, then 100%.
   // The 100% can be omitted if you'd like.
   $widths: 25%, 75%, 100%;
   $colors: red, white, blue;

   @include equal-height-columns($widths, $colors);
 }
 ```
 
 ```css
 .col-1 {
  width: 25%;
  float: left;
}

.col-2 {
  width: 50%;
  float: left;
}

.col-3 {
  width: 25%;
  float: right;
}

.col-wrapper {
  background-image: -webkit-gradient(linear, 0% 50%, 100% 50%, color-stop(0%, #ff0000), color-stop(25%, #ff0000), color-stop(25%, #ffffff), color-stop(75%, #ffffff), color-stop(75%, #0000ff), color-stop(100%, #0000ff));
  background-image: -webkit-linear-gradient(left, #ff0000, #ff0000 25%, #ffffff 25%, #ffffff 75%, #0000ff 75%, #0000ff 100%);
  background-image: -moz-linear-gradient(left, #ff0000, #ff0000 25%, #ffffff 25%, #ffffff 75%, #0000ff 75%, #0000ff 100%);
  background-image: -o-linear-gradient(left, #ff0000, #ff0000 25%, #ffffff 25%, #ffffff 75%, #0000ff 75%, #0000ff 100%);
  background-image: linear-gradient(left, #ff0000, #ff0000 25%, #ffffff 25%, #ffffff 75%, #0000ff 75%, #0000ff 100%);
}
```

By default, the built gradient will go from left to right, but you can pass in a direction parameter to `equal-height-columns()`, or sets `$equal-height-columns-direction`, to change the direction. Valid directions are valid directions for CSS Gradients. Because of this, there are some interesting things you can do with this mixin, including reversing it for `[dir="rtl"]` by setting the direction to `right`, making horizontal stripes by setting the direction to `top` or `bottom`, or making diagonal stripes by setting direction to `top left`, `bottom right`, or something similar. Additionally, you can pass in fixed values for widths, and can even combine fixed and fluid measurements (but be careful doing that).

## Webfont Helpers

Webfonts are absolutely awesome, but working with them can be a bit tricky. Ligatures are super powerful and make fonts that that support them even more beautiful, but aren't on by default. Webfonts are awesome, but you need to wait for them to download and that can cause a Flash of Unstyled Text, which can be jarring and unpleasant. Toolkit provides some tools to ease this.

### Enable Ligatures

A simple mixin or silent extendable called `enable-ligatures`. Including either will enable ligatures in supported browsers.

```scss
h1 {
  @include enable-ligatures;
}

h2 {
  @extend %enable-ligatures;
}

h3 {
  @extend %enable-ligatures;
}
```
```css
h1 {
  -webkit-font-feature-settings:"liga","dlig";
  -moz-font-feature-settings:"liga=1, dlig=1";
  -moz-font-feature-settings:"liga","dlig";
  -ms-font-feature-settings:"liga","dlig";
  -o-font-feature-settings:"liga","dlig";
  font-feature-settings: "liga","dlig";
}

h2, h3 {
  -webkit-font-feature-settings:"liga","dlig";
  -moz-font-feature-settings:"liga=1, dlig=1";
  -moz-font-feature-settings:"liga","dlig";
  -ms-font-feature-settings:"liga","dlig";
  -o-font-feature-settings:"liga","dlig";
  font-feature-settings: "liga","dlig";
}
```

### Content Fade In

One of the big challenges of working with webfonts is the Flash of Unstyled Text. It happens when webfonts get applied after content is already rendered on the page, usually causing a jarring jump when they are. To help combat this, Google and Typekit teamed up to create [WebFont Loader](https://developers.google.com/fonts/docs/webfont_loader), a JavaScript library to add Font Events that you can hook in to using CSS and JavaScript to know whether your webfonts are loading, have successfully loaded, or have failed to load. As [Typekit](http://help.typekit.com/customer/portal/articles/6852) suggests, these can be utilized to more effectively take control over your staying and prevent FOUT. The `content-fade-in` mixin will set your content to a 0 opacity (allowing the page to paint correctly even while it's not visible) and when a loading class has been removed, will fade your content in to an opacity of 1. You have three options for the mixin, `$duration` to control how long the fadein should happen (defaults to 1s), `$loading` for the loading class (defaults to `'.wf-loading'`), and `$selector` for what selector to apply the the effect to (if not included, will apply it to the current selector you've used it in).

```scss
#main {
  @include content-fade-in;
}
```
```css
#main {
  opacity: 1;
  -webkit-transition: opacity 1s;
  -moz-transition: opacity 1s;
  -o-transition: opacity 1s;
  transition: opacity 1s;
}

.wf-loading #main {
  opacity: 0;
}
```

## Viewport

Currently in the Draft stage, but being implemented by Microsoft is the CSS directive [`@viewport`](http://dev.w3.org/csswg/css-device-adapt/#the-atviewport-rule). This mixin simply provides prefixing for the directive:

```scss
@include viewport {
	width: auto;
}
```

```css
@-webkit-viewport {
  width: auto;
}

@-moz-viewport {
  width: auto;
}

@-ms-viewport {
  width: auto;
}

@viewport {
  width: auto;
}
```

## Element Queries

This title is a little bit of a misnomer; the following mixin won't provide true element query support, but rather is a solution to a question [proposed by Filament Group](http://filamentgroup.com/lab/element_query_workarounds/) as to how to work around not having element queries. Because this deals with Media Queries, this module pulls in [Breakpoint](https://github.com/Team-Sass/breakpoint) (Example is the example they use in their post).

```scss
.schedule-component {
  @include element-query('.content' 32.5em, 'aside' 90em) {
    ...styles here...
  }
}
```

```css
@media (min-width: 32.5em) {
  .content .schedule-component {
    ...styles here...
  }
}

@media (min-width: 90em) {
  aside .schedule-component {
    ...styles here...
  }
}
```

Because the media query portion is working through Breakpoint, you have access to the entire range of media query possibilities that Breakpoint provides.

## Carousels

Carousels provides a pure CSS3 rotating carousel. Currently, it does not provide fallbacks to non-CSS3 compatible browsers. It's also not user-controllable, they simply rotate through. That all being said, they're fun. An example of a carousel built using Toolkit's carousel component is available on [Snugug's](http://github.com/snugug) [Responsive Training Site](http://snugug.github.io/responsive-training-site/) demo.

Carousels are Toolkit's first foray into User Interface components, and as such, may wind up being moved to [UI Kit](https://github.com/Team-Sass/uikit) when it is ready to be used. The Carousel mixins provide a way to create a CSS Only sliding carousel. **Carousels require functionality in Compass 0.13 and as such is not imported by default!** As of this writing, Compass 0.13 can be installed by running `gem install compass --pre`. Once you have Compass 0.13 installed, you need to import Carousels separately using `@import "compass/carousel";`.

### CSS Carousel Component

The first part of the carousel is the carousel itself, provided by the `css-carousel-component` mixin. It expects HTML that looks like the following:

```markup
<wrapper>
  <slider>
    <slide>
      Slide Content
    </slide>
    <slide>
      Slide Content
    </slide>
  </slider>
</wrapper>
```

You can use any markup for wrapper/slider/slide you would like, and select them however you'd like. By default, the `css-carousel-component` mixin is going to use `> ul` for the slider and `> li` for the slides, but this can be changed globally by changing `$css-carousel-slider` or `$css-carousel-slide` respectively and on a per-carousel basis by passing in `$slider` or `$slide` respectively.

When using the carousel component, there is one thing that is must be known, and that's how many items there are in your carousel. Applying the carousel to your wrapper is as easy as follows (using `5` for the number of items and `.carousel` as a wrapper, using all of the defaults for the example):

```scss
.carousel {
  @include css-carousel-component(5);
}
```

This will produce the following CSS:

```css
.carousel {
  overflow: hidden;
  width: 100%;
}
.carousel img {
  display: block;
  width: 100%;
  max-width: 100%;
  height: auto;
}

.carousel > ul {
  list-style: none;
  margin: 0;
  padding: 0;
  position: relative;
  overflow: hidden;
}

.carousel > ul > li {
  position: relative;
  float: left;
}

.carousel > ul {
  width: 500%;
}
.carousel > ul > li {
  width: 20%;
}
.carousel > ul {
  -webkit-animation: carousel 30s infinite;
  -moz-animation: carousel 30s infinite;
  -o-animation: carousel 30s infinite;
  animation: carousel 30s infinite;
}
```

By default, it will use an animation named `'carousel'` (which can be changed globally by changing `$css-carousel-animation` or on a per-carousel basis by passing in an animation name to `$animation`) and a duration of `30s` (which can be changed globally by changing `$css-carousel-duration` or on a per-carousel basis by passing in a time duration to `$duration`). It will also attempt to optimize your the output by utilizing `@extend`; if you would prefer it did not, you can change that globally by setting `$css-carousel-extend` or on a per-carousel basis by passing in a boolean to `$extend`.

### CSS Carousel Animation

The second part of the carousel is the actual CSS animation to make the carousel slide around! This is provided by the `css-carousel-animation` mixin. When writing the animation, like the component, there is one thing that must be known, and that's how many items there are in your carousel. Creating the animation is as easy as follows (using `5` for the number of items):

```scss
@include css-carousel-animation(5);
```

This will produce the following CSS (cross-browser prefixes removed for clarity):

```css
@keyframes carousel {
  0% {
    left: 0%;
  }

  7.5% {
    left: 0%;
  }

  12.5% {
    left: -100%;
  }

  20% {
    left: -100%;
  }

  25% {
    left: -200%;
  }

  32.5% {
    left: -200%;
  }

  37.5% {
    left: -300%;
  }

  45% {
    left: -300%;
  }

  50% {
    left: -400%;
  }

  57.5% {
    left: -400%;
  }

  62.5% {
    left: -300%;
  }

  70% {
    left: -300%;
  }

  75% {
    left: -200%;
  }

  82.5% {
    left: -200%;
  }

  87.5% {
    left: -100%;
  }

  95% {
    left: -100%;
  }

  100% {
    left: 0%;
  }
}
```

By default, it will create an animation that will reverse direction when it reaches the end (using `'reverse'`) but can be changed to go to the beginning of the carousel by changing it to `'start'` (which can be changed globally by changing `$css-carousel-action` or on a per-carousel basis by passing in an action name to `$action`) and a transition speed of `5` (which can be changed globally by changing `$css-carousel-speed` or on a per-carousel basis by passing in a number to `$speed`, the smaller the number the faster the transition). It will create the animation based on the value of the global `$css-carousel-animation`, but can be changed by passing in an animation name to `$name`.

## Debugging

Sometimes you need to draw a big dumb box around stuff to see where it is. Just be sure to remove it before showing the client, capisce?

### Defaults

```scss
$debug-extend: true !default;
$debug-color-default: red !default;
$debug-bkg-color-default: false !default;
```

### Use
```scss
#where-is-this-thing {
  @extend %debug-extend;
}
// or
#where-is-this-other-thing {
  // change the outline color
  @include debug(blue);
}
// or
#where-is-still-other-thing {
  // change the outline color and add a background
  @include debug($color: blue, $bkg-color: yellow);
}
```

```css
#where-is-this-thing {
  outline: 1px solid red;
}
// or
#where-is-this-other-thing {
  outline: 1px solid blue;
}
// or
#where-is-still-other-thing {
  outline: 1px solid blue;
  background-color: yellow;
}
```

## Odds and Ends

There are few odds and ends that Toolkit comes with as well, because they are needed, were needed at some point, or because they improve life for everyone.

* All of Compass gets imported if you import all of Toolkit! Convenient!
* A new String Replace function is available! Simply call `str-replace($find, $replace, $input)` and you'll get input passed back to you with the string replaced.
* Importing `toolkit/colours` or either of the full Toolkit imports includes [Color Schemer](https://github.com/Team-Sass/color-schemer)!
* Toolkit comes with a Box Sizing mixin that takes int account your level of legacy support. If you need support for IE<8 and `box-sizing: border-box;`, run `compass install toolkit/box-sizing` from your command line. This will place a `behaviors` folder with the relevant behavior in your project. Make sure it's 1 step back from your CSS Directory, move it if it's not.

## Templates

Toolkit comes with two templates to get you up and running building projects with Toolkit very quickly. The first one is a basic project template that includes Toolkit. The second is a toolkit to jumpstart your Responsive Web Design projects, and it comes with both [Singularity 1.0](https://github.com/Team-Sass/Singularity) and [Breakpoint 2.0](https://github.com/team-sass/breakpoint).

To install either template, enter the following from your command line.

**Basic Toolkit**

```bash
compass create <my_project> -r toolkit --using toolkit
```

**Responsive Web Design Kickstart**

```bash
compass create <my_project> -r toolkit --using toolkit/rwd
```

## License

(c) Sam Richard, Scott Kellum 2012

Toolkit is dual licensed under the [MIT](http://www.opensource.org/licenses/mit-license.php) and [GPL](http://www.gnu.org/licenses/gpl.html) Licenses.
