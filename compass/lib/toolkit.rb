require 'compass'
require 'singularitygs'
require 'sassy-strings'
require 'color-schemer'

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('toolkit', :path => extension_path)

module Sass::Script::Functions
  def children_of_ie_nth(input)
    n = "n"
    b = ""
    result = input.value.gsub(n, b)
    Sass::Script::Number.new(result.to_i)
  end
end