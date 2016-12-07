base_directory  = File.expand_path(File.join(File.dirname(__FILE__), '..'))
toolkit_stylesheets_path = File.join(base_directory, 'stylesheets')

if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => base_directory
  )
else
  ENV["SASS_PATH"] = [ENV["SASS_PATH"], toolkit_stylesheets_path].compact.join(File::PATH_SEPARATOR)
end


module Toolkit
  VERSION = "2.10.2"
  DATE = "2016-12-07"
end
