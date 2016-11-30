# Toolkit [![Gem Version](https://badge.fury.io/rb/toolkit.png)](http://badge.fury.io/rb/toolkit) [![Build Status](https://travis-ci.org/Team-Sass/toolkit.png?branch=2.x.x)](https://travis-ci.org/Team-Sass/toolkit)

Think of Toolkit as your swiss army knife for modern design and development. Those little bits and bobs that make your life easy and you want to reuse throughout projects but never really had a place to put? They're here, and they're designed to make your life happy. Toolkit is broken out into individual pieces, so grab what you want, grab what you need, or grab the lot; the choice is yours.

## Table of Contents

1. [Basics](#basics)
  * [Requirements](#requirements)
  * [Installation](#installation)
  * [Changing Settings](#changing-settings)
  * [Extends](#extends)
1. [Art](#art)
1. [Clearfix](#clearfix)
1. [Colors](#colors)
  * [Tint and Shade](#tint-and-shade)
  * [Luma](#luma)
  * [Color Stacks](#color-stacks)
  * [Color Scales](#color-scales)
1. [DRY Mixins](#dry-mixins)
1. [Font Helpers](#font-helpers)
  * [Enable Ligatures](#enable-ligatures)
  * [Font Face](#font-face)
  * [Icon Font](#icon-font)
  * [Content Fade In](#content-fade-in)
1. [Intrinsic Ratios](#intrinsic-ratios)
1. [Kickstart](#kickstart)
1. [Nested Context](#nested-context)
1. [Parallax](#parallax)
1. [Reset](#reset)
1. [RTL](#rtl)
1. [Settings](#settings)
1. [Triangles](#triangles)
1. [Center](#center)
	* [Vertical Center](#vertical-center)
	* [Horizontal Center](#horizontal-center)
	* [Absolute Center](#absolute-center)
1. [Viewport](#viewport)
1. [Underline](#underline)
1. [Target](#target)
1. [Set Multiple](#set-multiple)

## Basics

Working with, and understanding how, Toolkit is fairly easy as long as you keep the following in mind:

### Requirements

Toolkit is a Sass plugin available both as a Compass Extension or as Bower Package. To use, make sure you have [Sass](http://sass-lang.com/install) installed. Any Sass compiler that is feature-compatible with Sass 3.3 can be used with Toolkit, so feel free to use whatever you feel is best!

### Installation

To install as a Compass extension, add the following to your Gemfile:

```ruby
gem 'toolkit', '~>2.0'
```

Then, add `require 'toolkit'` to your `config.rb` file and `@import "toolkit";` to your Sass file.

To install as a Bower package, run the following:

```bash
bower install sass-toolkit --save-dev
```

Even as an [Eyeglass](https://github.com/sass-eyeglass/eyeglass) module!

```bash
npm install sass-toolkit --save-dev
```

### Changing Settings

All of Toolkit's settings can be changed with a simple mixin. Whenever you would like to change a default, include the following mixin, and from then on out, whenever that default is needed, the value you've changed it to will be used:

```sass
@include toolkit-set('setting', value);
```

### Extends

Where appropriate, Toolkit mixins provide an `$extend` option to allow the shared output of a mixin to be set to an extendable class instead of duplicating the properties. Toolkit is super smart about this and will create the extendable class in place where you first call the mixin, allowing you to not worry about blowing up your cascade if you use it. All mixins that have an `extend` setting can have a portion of their mixin extended. By default, mixins won't extend, but you can change that by changing their global setting or by passing `$extend: true` to the mixin.

### Documentation Format

Each mixin/function definition looks like the following:

#### @include clearfix([$extend])

**Settings**

- `'clearfix extend': false`

Mixins start with `@include`, functions don't. Variables in [brackets] are optional. Settings are global setting variables that provide the defaults for optional variables, with their default.

## Art

Create pixel art using [CSS Box Shadows](http://sassmeister.com/gist/cf4a1eff8326585d66e6)! Simply write a string with `x` for where you'd like a pixel, and ` ` where you wouldn't. When you want a new line, simply write `\n`. The "pixel" size is the size of one pixel and doesn't have to be `px`. Border radius will apply to each "pixel", as will color.

#### @include art($art[, $px-size, $color, $radius])

- `'art pixel size': 1px`
- `'art color': black`
- `'art border radius': 0%`

## Clearfix

Use a clearfix to ensure a parent element that contains floated children encompasses its children. Toolkit's clearfix is a [modern clearfix](http://www.css-101.org/articles/clearfix/latest-new-clearfix-so-far.php).

#### @include clearfix([$extend])

**Settings**

- `'clearfix extend': false`

## Colors

Sass comes with a [slew of great color functions](http://sass-lang.com/documentation/Sass/Script/Functions.html), made even better by [color schemer](https://github.com/team-sass/color-schemer), but there are a few handy things missing to make working with groups of colors easier

### Tint and Shade

While Sass's built in `lighten` and `darken` functions are great if you're looking not to change the base color, they aren't what designers think of when they think of lightening or darkening a color. The mental model for those is actually mixing white or black to lighten or darken a color. So, like so many others, we have a `tint` and `shade` function that will do just that. Simply pass the color and the amount you want. For instance, if you wanted a red that was 25% lighter or darker than the standard CSS red, you'd do one of the followings:

#### @include tint($color, $amount)

**Settings**

- `'tint color': #fff`

#### @include shade($color, $amount)

**Settings**

- `'shade color': #000`

### Luma

[Luma](http://en.wikipedia.org/wiki/Luminance_(video)) represented the brightness in an image (the "black-and-white" or achromatic portion of the image). As human vision is much more sensitive to luminance ("black and white") than it is to chromatic differences ("colors"), luma provides an effective means of determining how a human will react to the relative brightness of a color. The Luma functions are based on the conversion to the [YIQ](http://en.wikipedia.org/wiki/YIQ) color space, with Y being luma (also, the only component used in black-and-white televisions). The `luma` function provided will return the luma value for a color, and the additional helpers can be used for common tasks related to luma, such as if one color's luma is greater than and equal to or less than or equal to a second colors, and the difference between two colors' luma.

#### @include luma($color)

#### @include luma-gte($color1, $color2)

#### @include luma-lte($color1, $color2)

#### @include luma-diff($color1, $color2)


### Color Stacks

One technique for working with color that is very useful is to create color stacks that get either lighter or darker as they go, allowing me to easily create full color pallets with only a handful of base colors and then only needing to remember those base colors. These are called color stacks, and making them with Toolkit is super easy. A sample color stack, if written by hand, may look something like the following:

```scss
$red: red, #ff3f3f, #ff7f7f, #ffbfbf, #ffd8d8, #fff2f2;
```

This is a color stack for red that gets tinted as it goes (25%, 50%, 75%, 85%, 90%). To make figuring these out easier, there is the `color-stack` function that takes two required parameters, the main color you want to use and the secondary color you want to use (in the case of shading red, the main color would be red and the secondary color would be black), and a variable number of arguments of what percent you want them mixed. Tint stacks, shade stacks, and tint to shade stacks are also available.

#### @include color-shade($main, $secondary [, $amounts...])

**Settings**

- `'color stack amounts': 25% 50% 75% 85% 90%`

#### @include tint-stack($main [, $amounts...])

**Settings**

- `'tint color': #fff`
- `'color stack amounts': 25% 50% 75% 85% 90%`

#### @include shade-stack($main [, $amounts...])

**Settings**

- `'shade color': #000`
- `'color stack amounts': 25% 50% 75% 85% 90%`

#### @include tint-shade-stack($main [, $amounts...])

**Settings**

- `'tint color': 75% 50% 25%`
- `'shade color': #000`
- `'tint shade amounts': 75% 50% 25%`

### Color Scales

Color scales allow you to step from one color to another in even steps. Color scale will scale your first color to your second color evenly by hue, saturation, lightness, and alpha. Hue will take the fastest path around the color wheel

#### @include color-scale($main, $secondary [, $steps...])

**Settings**

- `'color scale steps': 6`

## DRY Mixins

The pattern that inspired the [A List Apart](http://alistapart.com/) article [DRY-ing Out Your Sass Mixins](http://alistapart.com/article/dry-ing-out-your-sass-mixins), now available for you to use in your projects! The full writeup on the why can be found in the article, and examples can be found all throughout Toolkit.

#### @include dynamic-extend($id) { @content }

The `dynamic-extend` mixin is the core mixin for dynamically creating placeholder selectors and extending them directly.

#### @include mixin-dryer($id [,$extend: true]) { @content }

The `mixin-dryer` mixin is a one-stop-shop mixin for working with the whole pattern. It wraps the contents of the **static** portion of the pattern into a single mixin. If you don't think someone would want to use the static mixin on its own, simply drop `mixin-dryer` into your core mixin and you're good to go! The button example from A List Apart can be written with this mixin as follows:

```scss
@mixin button($color, $extend: true) {
  background-color: $color;
  border-color: mix(black, $color, 25%);

  &:hover {
    background-color: mix(black, $color, 15%);
    border-color: mix($black, $color, 40%);
  }

  @include mixin-dryer('button', $extend) {
    border: 1px solid;
    border-radius: 5px;
    padding: .25em .5em;

    &:hover {
      cursor: pointer;
    }
  }
}
```

## Font Helpers

Web fonts are absolutely awesome, but working with them can be a bit tricky. Ligatures are super powerful and make fonts that that support them even more beautiful, but aren't on by default. Webfonts are awesome, but you need to wait for them to download and that can cause a Flash of Unstyled Text, which can be jarring and unpleasant. Toolkit provides some tools to ease this.

### Enable Ligatures

A simple mixin to enable ligatures

#### @include enable-ligatures([$extend])

**Settings**

- `'ligature extend': false`

### Font Face

A mixin to make writing `@font-face` declarations easy. `$files` should be a map where the key is the file extensions and the value is the path. If using Compass, paths should be relative to your font directory (`fonts_dir` in `config.rb`). If Compass is available, this mixin can inline the `woff` file, thus caching it with your CSS

#### @include font-face($name, $files [, $weight, $style, $inline-woff])

**Settings**

- `'font face weight': normal`
- `'font face style': normal`
- `'font face inline woff': false`

### Icon Font

A mixin for applying a core set of styling for icon fonts, based on styling form fonts generated by [Icomoon](http://icomoon.io). Setting `$speak: false` will optionally apply the [`speak: none`](http://webdesign.about.com/od/styleproperties/p/blspspeak.htm) property.

#### @include icon-font($font-stack, [, $speak, $extend])

**Settings**

- `'icon font speak': false`
- `'icon font extend': false`

### Content Fade In

One of the big challenges of working with webfonts is the Flash of Unstyled Text. It happens when webfonts get applied after content is already rendered on the page, usually causing a jarring jump when they are. To help combat this, Google and Typekit teamed up to create [WebFont Loader](https://developers.google.com/fonts/docs/webfont_loader), a JavaScript library to add Font Events that you can hook in to using CSS and JavaScript to know whether your webfonts are loading, have successfully loaded, or have failed to load. As [Typekit](http://help.typekit.com/customer/portal/articles/6852) suggests, these can be utilized to more effectively take control over your staying and prevent FOUT. The `content-fade-in` mixin will set your content to a 0 opacity (allowing the page to paint correctly even while it's not visible) and when a loading class has been removed, will fade your content in to an opacity of 1.

#### @include content-fade-in([$duration, $loading, $extend])

**Settings**

- `'fade in duration': 1s`
- `'fade in loading class': '.wf-loading'`
- `'fade in extend': false`

## Intrinsic Ratios

What is an intrinsic ratio you may ask? Well Thierry Koblentz wrote a great [A List Apart article](http://www.alistapart.com/articles/creating-intrinsic-ratios-for-video/) explaining it all in great detail; go read it. In a nutshell, however, it's a way to force any child elements to fluidly scale at a given ratio, including videos and frames, making awesome responsive happiness. If you just want to change the ratio, use the `intrinsic-ratio-ratio` mixin.

#### @include intrinsic-ratio([$ratio, $width, $elements, $position, $extend])
#### @include ir([$ratio, $width, $elements, $position, $extend])

**Settings**

- `'intrinsic ratio': 16/9`
- `'intrinsic ratio width': 100%`
- `'intrinsic ratio elements': '> *'`
- `'intrinsic ratio position': top`
- `'intrinsic ratio extend': false`

#### @include intrinsic-ratio-ratio([$ratio, $width, $position])
#### @include ir-ratio([$ratio, $width, $position])

**Settings**

- `'intrinsic ratio': 16/9`
- `'intrinsic ratio width': 100%`
- `'intrinsic ratio position': top`

## Kickstart

Importing the kickstart partial with `@import "toolkit/kickstart";` will add the following common styles to your project:

```scss
html {
  -moz-box-sizing: border-box;
       box-sizing: border-box;
}

*, *:before, *:after {
  box-sizing: inherit;
}

embed,
img,
object,
video {
  max-width: 100%;
  height: auto;
}
```

## Nested Context

Sometimes we may be inside of an element but need something the width of its parent.

![Basic nested context](http://img.pgdn.us/nested-context.png)

This is easy with fixed widths because then we can just make the child the width we want it but percentages change with each new context. With just a little bit of math we can pretty easily figure out what context we are in and it is condensed in the `nested-context()` function. Simply write how wide your current container is and it will figure out how wide it’s parent is like `nested-context(30%)` will give you a percentage to match the parent. Sometimes you are multiple levels deep and in that case, you can just list the levels `nested-context(80% 60% 33%)` and result in a percentage matching that of the 3rd parent up. See the [nested context](http://codepen.io/scottkellum/pen/vGuaI) and [centered nested context](http://codepen.io/scottkellum/pen/mwlGe) examples.

#### nested-context([$contexts])

**Settings**

- `'nested context contexts': 100%`

#### @include nested-context([$contexts, $position])

**Settings**

- `'nested context contexts': 100%`
- `'nested context position': left`

## Parallax

The concept of the parallax effect is simple, things closer to the viewer move faster while things further away move slower. Leveraging 3D transforms, this effect can be implemented without any JavaScript. You need to initialize your parallax container before being able to parallax an item. By default iOS parallax is on but setting it to false will turn on smooth scrolling within that element and no parallax effect will be shown.

The parallax mixin puts elements into real perspective and scales them back down to 100% so images and text will not have any distortion. Items will shift both vertically and horizontally in layouts to achieve the appropriate perspective. With `@include init()`, if `$element: this`, the current element will be initialized; if `$element: '.class'|'#id'`, the respective element will be placed at the root of the stylesheet (not nested under the current selector). `@include init()` can be called from the root of your stylesheet.

#### @include parallax-init([$perspective, $element, $parallax-ios])

**Settings**

- `'parallax perspective': 1`
- `'parallax element': 'body'`
- `'parallax ios': true`

#### @include parallax([$distance, $perspective])

**Settings**

- `'parallax perspective': 1`
- `'parallax distance': 0`

## Reset

Importing the reset partial with `@import "toolkit/reset";` will add a CSS Reset in based on work done by [Nicholas Gallagher and Jonathan Neal](http://necolas.github.io/normalize.css/), [Richard Clark](http://richclarkdesign.com), and [Tim Murtaugh](http://monkeydo.biz/), and some other things that are useful. Also includes the [kickstart](#kickstart).

## RTL

Quickly and easily write your left-to-right and right-to-left properties with one mixin! Works for `*-left` and `*-right` properties, as well as shorthand syntaxes.

#### @include rtl($property, $value)

## Settings

While the standard `$variable: value !default` for allowing users the ability to change defaults in a system is okay, it can become cumbersome quickly. Cascading user changes is hard, doesn't always work as expected, and for large systems all of those settings pollute the global namespace. These setting functions and mixins make it easy to work with setting in the same way that [Toolkit does](#changing-settings). We're even dogfooding here, using these internally to work with Toolkit's settings! And none of our tests broke when we made the transition!

### User Setting Exists

Used to see if a user has set a setting. Will return `true` or `false`.

#### user-setting-exists($setting)

Pass in a comma separated list of user settings you would like to test. Will return a map where the keys are the settings and the values are their respective state.

#### user-setting-exists-multiple($settings...)

### Setting Get

Used to retrieve a setting. Will attempt to find the user setting first, and if a user hasn't set a value for that setting, will use the default setting. Returns the value of the setting

#### setting-get($setting)

Pass in a comma separated list of user settings you would like to retrieve. Will return a map where the keys are the settings and the values are their respective values.

#### setting-get-multiple($setting...)

### Setting Set

Used to set a setting. Returns `true`. The function and the mixins take the same input.

#### setting-set($setting, $value)

#### @include setting-set($setting, $value)

#### @include setting-change($setting, $value)

Used to set multiple settings at once. The input should be a map where the key is the setting and the value is the value of said setting.

#### setting-set-multiple($settings)

#### @include setting-set-multiple($settings)

#### @include setting-change-multiple($settings)

### Setting Clear

Used to clear a single user setting. Will return `true`. The function and the mixins take the same input.

#### setting-clear($setting)

#### @include setting-clear($setting)

Pass in a comma separated list of user settings you would like to clear. Will return `true`. The function and the mixins take the same input.

#### setting-clear-multiple($settings...)

#### @include setting-clear-multiple($settings...)

Used to clear all user settings. Will return `true`. The function and the mixins take the same input.

#### setting-reset()

#### @include setting-reset()

### Setting Pick

The most common usecase of actually needing to determine the setting to use is within a custom function or mixin. The recommended way of doing this is to provide a default value of `null` for arguments that are controlled by settings, then check to see if that value is `null` and, if not, get the correct setting. The setting pick functions do this.

#### setting-pick($setting, $input)

Used to pick multiple settings at once. The input should be a map where the key is the setting and the value is the input to be tested. Will return a map where the keys are the setting and the value is the determined value.

#### setting-pick-multiple($settings)

```scss
@mixin button($size, $color: null) {
  $color: setting-pick('button color', $color);
  // ... rest of stuff goes here
}
```

### Setting Defaults

Congratulations! You now have an API for working with setting that you didn't need to write! Awesome! But how do you actually make global settings to use? Well, simple. Create a map of your settings, the keys being the setting name, the values being the value of the setting, and merge it into the `$GlobalSettings` variable. This will put them in the global setting namespace. If you would like your variables namespaced, it's recommended that you write wrapper functions for the setting functions for your plugin.

```scss
@import "toolkit";

$MyAwesomePluginSettings: (
  'button color': #b4d455,
  'mug fill color': #c0ffee
);

$GlobalSettings: map-merge($GlobalSettings, $MyAwesomePluginSettings);

// ... The rest of your awesome plugin stuff here
```


## Triangles

You love em! Triangles! Now create them using just CSS! Turn any element or pseudo element into a triangle just by using the `@include triangle;`. It's perfect for flags, speech bubbles, and arrows.

Width and height just stretch the triangle to match a width or height. You can use any units you want although percentages don't work so well. Angle is where the  point of the triangle is drawn opposing one side. This is a little diffucult to explain, so here is a gif. If the width and height are not uniform, then the angle will be stretched to match the triangles proportions. The mixin also supports keywords like `top`, `top right`, `right` and so on for the angle. The triangle will point in the direction you give it.

![triangle](http://img.pgdn.us/triangle2.gif)

![triangle example](http://img.pgdn.us/triangle-ex.png)

#### @include triangle([$color, $height, $width, $angle])

**Settings**

- `'triangle color': #000`
- `'triangle height': 1em`
- `'triangle width': 1em`
- `'triangle angle': 0`

## Center

> We can do [insert seemingly impossible thing here] but we can't even center with CSS
>
> *Unfunny people on the Internet*

Yes, Flexbox will give us a native way to center things when it finally arrives, but until then, and for all of the browsers that don't support Flexbox, a few handy mixins for centering vertically, horizontally, or both!


### Vertical Center

Vertical center anything, literally anything, with the `vertical-center` mixin. Based on [Sebastian Ekström’s vertical align technique](http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/).

#### @include vertical-center([$midpoint, $extend])

**Settings**

- `'vertical midpoint': 50%`
- `'vertical extend': false`

### Horizontal Center

Horizontal center anything, literally anything, with the `horizontal-center` mixin. Based on [Sebastian Ekström’s vertical align technique](http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/) for fixed position items and good 'ol `margin: 0 auto` for everything else.

#### @include horizontal-center([$midpoint, $fixed, $extend])

**Settings**

- `'horizontal fixed': false` (fixed position item)
- `'horizontal extend': false`
- `'horizontal midpoint': 0%`
- `'horizontal fixed midpoint': 50%` (midpoint for fixed position item)

### Absolute Center

I want it in the middle. The absolute middle. The middle of the middle of the middle. The absolute middle of the middle of the middle of the middle.

#### @include absolute-center([$vertical, $horizontal, $fixed, $extend])

**Settings**

- `'absolute center fixed': false` (fixed position item)
- `'absolute center extend': false`
- `'absolute center vertical midpoint': 50%`
- `'absolute center fixed horizontal': 0%` 
- `'absolute center fixed horizontal midpoint': 50%` (horizontal midpoint for fixed position item)

## Viewport

Currently in the Draft stage, but being implemented by Microsoft is the CSS directive [`@viewport`](http://dev.w3.org/csswg/css-device-adapt/#the-atviewport-rule). This mixin simply provides prefixing.

#### @include viewport { @content }

## Underline

Create beautiful underlines [à la Medium](https://medium.com/designing-medium/7c03a9274f9)! Now with the ability to clear descenders!

#### @include underline([$background, $color, $clear-descenders, $distance, $width])

**Settings**

- `'underline background': #f00`
- `'underline color': #00e`
- `'underline clear descenders': true`
- `'underline distance': 1` (unitless number)
- `'underline width': 2` (unitless number)
- `'underline extend': false`

## Target

Creates specially formatted comments for use with [gulp-css-target](https://github.com/snugug/gulp-css-target)

#### @include target($target) { @content }

## Set Multiple

Applies the same property to multiple values.

#### @include set-multiple($value, $property-list);

```scss
  .box {
    @include set-multiple(50%, width height);
  }
```

```css
  .box {
    width: 50%;
    height: 50%;
  }
```

## License

Copyright (C) 2011-2015 by Sam Richard

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
