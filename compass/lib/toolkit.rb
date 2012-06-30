require 'compass'
require 'susy'
require 'respond-to'

extension_path = File.expand_path(File.join(File.dirname(__FILE__), ".."))
Compass::Frameworks.register('toolkit', :path => extension_path)
