# Toolkit

**Progressive Enhancement? Simple. Responsive Web Design? Done.**

Think of Toolkit as your swiss army knife for Progressive Enhancement and Responsive Web Design. Those little bits and bobs that make your life easy and you want to reuse throughout projects but never really had a place to put? They're here, and they're designed to make your life happy. Toolkit is broken out into individual pieces, so grab what you want, grab what you need, or grab the lot; the choice is yours.

## Table of Contents

1. [Border Box](#border-box)
2. [Fluid Media](#fluid-media)
   * [Fluid Images](#fluid-images)
   * [Intrinsic Ratios](#intrinsic-ratios)
3. [Progressive Enhancement](#progressive-enhancement)
   * [Enhance and Degrade](#enhance-and-degrade)
   * [Progressively Enhanced Background Images](#progressively-enhanced-background-images)
   * [Progressively Enhanced Text Replacement](#progressively-enhanced-text-replacement)
4. [Clearfix](#clearfix)
5. [Vertical Center](#vertical-center)
6. [Odds and Ends](#odds-and-ends)
6. [Templates](#templates)

## Requirements

Toolkit is a Compass extension, so make sure you have [Sass and Compass Installed](http://compass-style.org/install/) in order to use its awesomeness!

Toolkit also requires Sass 3.2. Breakpoint should install Sass 3.2 for you when you install it, but in case you are getting errors, open up your terminal and type the following in:

`gem install sass`

This will install Sass 3.2. If you are compiling with CodeKit, [Chris Coyier has an awesome writeup](http://css-tricks.com/media-queries-sass-3-2-and-codekit/) on how to get CodeKit playing nice with Sass 3.2, at least until it is updated to 3.2.

## Installation

`gem install toolkit`

#### If creating a new project
`compass create <my_project> -r toolkit`

#### If adding to existing project, in config.rb
`require 'toolkit`

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

Sass will not magically give you responsive media. Neither will Compass, Modernizr, or any CSS or JavaScript Framework. For responsive media to be a reality, we need a new browser based standard. There currently is a [proposed solution for images](http://www.w3.org/community/respimg/) to the World Wide Web Consortium, and Apple may be forging ahead in iOS 6 with a [solution one of their developers proposed](http://www.whatwg.org/specs/web-apps/current-work/multipage/embedded-content-1.html) to the Web Hypertext Application Technology Working Group, but until there is a standard, everything is a hack.

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

What is an intrinsic ratio you may ask? Well Thierry Koblentz wrote a great [A List Apart article](http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/) explaining it all in great detail; go read it. In a nutshell, however, it's a way to force any child elements to fluidly scale at a given ratio, including videos and frames, making awesome responsive happiness. Provided is a `intrinsic-ratio` mixin that takes three inputs: `$ratio` which defaults to `16/9` for the ratio you want to use, `$width` which defaults to `100%` for what percentage of the parent width you want the scaled elements to take up, and `$elements` which defaults to `*` for what child elements you want this to apply to. By default, the mixin will try and optimize your output as much as possible and group pieces of the output together to provide smaller CSS output, but if you set `$extend: false` as a parameter of the mixin call, it won't. An example of how you can use intrinsic ratios:

```scss
.ratio-16-9 {
  @include intrinsic-ratio;
}

.ratio-4-3-75 {
  @include intrinsic-ratio(4/3, 75%);
}

.ratio-7-8-75-iframe-inline {
  @include intrinsic-ratio(7/8, 75%, 'iframe', true);
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
  width: 100%;
  height: 100%;
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

.ratio-7-8-75-iframe-inline {
  position: relative;
  height: 0;
  padding-top: 85.71429%;
  width: 75%;
}

.ratio-7-8-75-iframe-inline > iframe {
  display: block;
  position: absolute;
  width: 100%;
  height: 100%;
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
```

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

## Odds and Ends

There are few odds and ends that Toolkit comes with as well, because they are needed, were needed at some point, or because they improve life for everyone.

* All of Compass gets imported if you import all of Toolkit! Convenient!
* A new String Replace function is available! Simply call `str-replace($find, $replace, $input)` and you'll get input passed back to you with the string replaced.

## Templates

Templates are awesome little things designed to get you up and moving with all of the awesomeness that Toolkit has to offer, and then some. The templates Toolkit comes with include an array of options to kickstart your responsive web design projects in a matter of a single line in your terminal. They bring in the best that the Compass community has to offer in terms of Responsive Web Design tools and let you run free.

Templates should be used when first starting a project. Each template comes with Toolkit, a grid system, and a media query system, as well as a custom development build of Modernizr that includes yep nope, a JavaScript file to hold yep nope loads, and [Hammer.js](http://eightmedia.github.com/hammer.js/) for awesome touch interactions. The two grids you have to choose from are [Susy](http://susy.oddbird.net), an amazing semantic, symmetric grid system, and [Singularity](http://singularity.gs), a new and kick ass asymmetric and odd grid system. The two media query systems you have to choose from are vanilla [Breakpoint](http://github.com/canarymason/breakpoint) and Breakpoint with the [Respond-to](http://github.com/snugug/respond-to) syntax. Using them is very easy:

**Susy with Breakpoint**

```bash
compass create <my_project> -r toolkit --using toolkit/susy
```

**Susy with Respond-to**

```bash
compass create <my_project> -r toolkit --using toolkit/susy-respond-to
```

**Singularity with Breakpoint**

```bash
compass create <my_project> -r toolkit --using toolkit/singularity
```

**Singularity with Respond-to**

```bash
compass create <my_project> -r toolkit --using toolkit/singularity-respond-to
```

If you would like to install the full Toolkit into an existing project, make sure you require Toolkit in your config.rb file, then put the following into your command line:

```bash
compass install toolkit
```

## License

(c) Sam Richard, 2012

Toolkit is dual licensed under the [MIT](http://www.opensource.org/licenses/mit-license.php) and [GPL](http://www.gnu.org/licenses/gpl.html) Licenses.