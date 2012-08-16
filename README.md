# Toolkit

** Progressive Enhancement? Simple. Responsive Web Design? Done. **

Think of Toolkit as your swiss army knife for Progressive Enhancement and Responsive Web Design. Those little bits and bobs that make your life easy and you want to reuse throughout projects but never really had a place to put? They're here, and they're designed to make your life happy. Toolkit is broken out into individual pieces, so grab what you want, grab what you need, or grab the lot; the choice is yours.

## Table of Contents

1. [Border Box](#border-box);
2. [Fluid Media](#fluid-media);
   * [Fluid Images](#fluid-images)
   * [Intrinsic Ratios](#intrinsic-ratios)
3. [Progressive Enhancement](#progressive-enhancement)
   * [Enhance and Degrade](#enhance-and-degrade)
   * [Progressively Enhanced Text Replacement](#progressively-enhanced-text-replacement)
4. [Clearfix](#clearfix)
5. [Vertical Align](#vertical-align)
6. [Odds and Ends](#odds-and-ends)
6. [Templates](#templates)

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

### Fluid Images

This is the most basic of fluid image solutions: take an image, make sure you never make it larger than it natively is, and scale it to fit its holder when the holder gets small. Keep everything in proportion. This will add the following snippet to your code:

```scss
img {
  max-width: 100%;
  height: auto;
}
```

### Intrinsic Ratios

What is an intrinsic ratio you may ask? Well Thierry Koblentz wrote a great [A List Apart article](http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/) explaining it all in great detail; go read it. In a nutshell, however, it's a way to force any child elements to fluidly scale at a given ratio, including videos and frames, making awesome responsive happiness. Provided is a `scale-elements` mixin that takes three inputs: `$ratio` which defaults to `16/9` for the ratio you want to use, `$width` which defaults to `100%` for what percentage of the parent width you want the scaled elements to take up, and `$elements` which defaults to `*` for what child elements you want this to apply to. By default, the mixin will try and optimize your output as much as possible and group pieces of the output together to provide smaller CSS output, but if you set `$no-extend: true` as a parameter of the mixin call, it won't. An example of how you can use intrinsic ratios:

```scss
.ratio-16-9 {
  @include scale-elements;
}

.ratio-4-3-75 {
  @include scale-elements(4/3, 75%);
}

.ratio-7-8-75-iframe-inline {
  @include scale-elements(7/8, 75%, 'iframe', true);
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

### Progressively Enhanced Text Replacement

Text replacement is pretty good for accessibility and whatnot, but as is, it's not very good for progressive enhancement. There's a lot that goes in to text replacement in general, and then combine that with serving either a png or an sag (for resolution independence) and you start to have to write a lot of CSS for something fairly simple. Plus, we all like to use image sprites for our text replacement, right? RIGHT?! That's even more work that we need to deal with. Not any more! We can have Compass automate the whole process, and do it more efficiently than if we had done it by hand to boot. Setup is fairly easy, and there is only one major restriction: this method cannot currently be used from within a media query, but other than that, it's good to go!

#### The Setup

In you Images directory, create a directory to hold the images you want sprited together. All of the images must be in .png format. In that same directory, place the SVG files you want to use. Each .png file you want to use should have a corresponding .svg file with the same name. I'm going to create some social images, so I'm going to put them inside a social folder.

#### The Usage

Very easy. Make a variable set to what the folder name is inside your Images directory, include the sprite map generator mixin passing in that variable, then include the progressive replace text mixin with the variable and the name of the file you want to use! Couldn't be simpler.

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

#### The Output

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

** Susy with Respond-to**

```bash
compass create <my_project> -r toolkit --using toolkit/susy-respond-to
```

** Singularity with Breakpoint**

```bash
compass create <my_project> -r toolkit --using toolkit/singularity
```

** Singularity with Respond-to**

```bash
compass create <my_project> -r toolkit --using toolkit/singularity-respond-to
```

If you would like to install the full Toolkit into an existing project, make sure you require Toolkit in your config.rb file, then put the following into your command line:

```bash
compass install toolkit
```

## License

Toolkit is dual licensed under the [MIT](http://www.opensource.org/licenses/mit-license.php) and [GPL](http://www.gnu.org/licenses/gpl.html) Licenses.