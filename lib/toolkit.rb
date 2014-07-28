toolkit_sass_path = File.expand_path('../stylesheets', __FILE__)
toolkit_path = "#{File.dirname(__FILE__)}/.."

if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => toolkit_path
  )
else
  ENV["SASS_PATH"] = [ENV["SASS_PATH"], toolkit_sass_path].compact.join(File::PATH_SEPARATOR)
end


module Toolkit
  VERSION = "2.5.2"
  DATE = "2014-07-24"
end