# Uncomment when working:
require 'susy'
require 'breakpoint'
require 'respond-to'
require 'color-schemer'

# Uncomment when testing release gem:
# require 'toolkit'


# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "stylesheets"
sass_dir = "sass"
images_dir = "images"
javascripts_dir = "javascripts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

module Sass::Script::Functions
  def str_replace(needle, replace, haystack)
    result = haystack.value.gsub(needle.value, replace.value)
    Sass::Script::String.new(result)
  end

  def children_of_ie_nth(input)
    n = "n"
    b = ""
    result = input.value.gsub(n, b)
    Sass::Script::Number.new(result.to_i)
  end
end