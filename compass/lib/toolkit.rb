require 'compass'
require 'susy'
require 'respond-to'
require 'singularitygs'

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('toolkit', :path => extension_path)

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