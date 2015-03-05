# Toolkit

## v2.9.0
### March 4, 2015

* **New** Added `mixin-dryer` mixin to make writing your static mixin from [DRY-ing Out your Sass Mixins](http://alistapart.com/article/dry-ing-out-your-sass-mixins) much easier to do, all in line!

## v2.8.0

* **New** Added a CSS Reset!
* **Change** Updated Kickstart's box sizing definition to play nicer with other things.
* **Change** Added support for `woff2` to the `font-face` mixin

## v2.7.0

* **New** Added the `set-multiple` mixin to allow multiple properties to be set to the same value (thanks [@Robovirtuoso](https://github.com/Robovirtuoso)

## v2.0.0.alpha.7
### January 29, 2014

* **Fix** Intrinsic Ratio variable names, cause `$ration` !== `$ratio`
* **New** Bulletproof Vertical Center based on [Sebastian Keström's `transform`](http://zerosixthree.se/vertical-align-anything-with-just-3-lines-of-css/) technique

## v2.0.0.alpha.3
### January 14, 2014

* **Fix** Was calling `colour` mixins instead of `color` mixins. Fixed.

## v2.0.0.alpha.2
### January 14, 2014

* **Change** No dynamic mixin (turns out you can't do that)
* **Fix** All of the setting stuff

## v2.0.0.alpha.1
### January 14, 2014

* **New** Sass 3.3.0 compatible (required)
* **New** No Compass requirements
* **New** Includes no CSS
* **New** Kickstart partial (`toolkit/kickstart`) available to add universal box sizing and fluid images and videos
* **Change** Clearfix mixin no longer chooses the correct clearfix, only modern clearfix
* **Change** No English spelling of `colour`, only `color`
* **New** **Change** `enable-ligatures` mixin now takes parameter `$extend` to use extend using the `%enable-ligatures` selector
* **New** **Change** If `single-transition` mixin doesn't exist, will write the standard and `-webkit` properties based on [Can I Use](http://caniuse.com/css-transitions) current versions
* **Change** Parameter order for `intrinsic-ratio` and `ir` mixins changed from `$ratio, $width, $elements, $extend, $direction` to `$ratio, $width, $elements, $direction, $extend`
* **New** **Change** `enhance-with` and `degrade-from` mixins now take lists for the `$features` (changed from `$feature`) to allow for multiple selectors. Lists should be space separated, or wrapped in `()` for comma separated
* **Deprecation** `replace-text-pe`, `svg-background`, `retina-background`, `sprite-map-generator`, and support classes have been removed.
* **Change** `viewport` mixin no longer chooses the correct prefix, will add `-webkit`, `-moz`, and `-ms` prefixes
* **Deprecation** Removed all templates
* **New** **Change** Settings are now stored in a single place. If including individual partials, `toolkit/settings` must also be imported
* **New** **Change** Settings are now stored in a map. Use mixin `toolkit-change($setting, $value)` to change a value and `toolkit-reset($setting)` to reset a value. Settings and defaults are as follows:
	* **clearfix extend**: `false`
	* **color stack amounts**: `25% 50% 75% 85% 90%`
	* **tint color**: `#fff`
	* **shade color**: `#000`
	* **color scale shades**: `6`
	* **extend ligatures**: `false`
	* **fade in duration**: `1s`
	* **fade in loading class**: `'.wf-loading'`
	* **intrinsic ratio**: `16/9`
	* **intrinsic ratio width**: `100%`
	* **intrinsic ratio elements**: `> *`
	* **intrinsic ratio direction**: `top`
	* **intrinsic ratio extend**: `false` (**Change**, was `true`)
	* **nested context contexts**: `100%`
	* **nested context position**: `left`
	* **degrade from javascript**: `false` (**New**, for use with `degrade-from`)
	* **triangle color**: `#000`
	* **triangle height**: `1em`
	* **triangle width**: `1em`
	* **triangle angle**: `0`
* **Change** Element Query mixin now takes a map `(.small: 400px, .medium: 700px)` instead of a list. Map key is `selector` map value is `query`. Now works with or without [Breakpoint](https://github.com/team-sass/breakpoint). If using without Breakpoint, query should be full string (minus `@media`)
* **Deprecation** Removed dependencies on Color Schemer, Singularity, and Sassy Strings
* **Deprecation** Removed Border Box
* **Deprecation** Removed Box Sizing
* **Deprecation** Removed Carousel
* **Deprecation** Removed Children of IE
* **Deprecation** Removed Equal Height Columns
* **Deprecation** Removed Fluid Media
* **Deprecation** Removed Vertical Center
* **Deprecation** Removed Progressive Enhancement Text Replace, Retina Background, and SVG Background
