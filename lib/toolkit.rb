toolkit_path = File.expand_path('../stylesheets', __FILE__)

if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :stylesheets_directory => toolkit_path
  )
else
  ENV["SASS_PATH"] = [ENV["SASS_PATH"], toolkit_path].compact.join(File::PATH_SEPARATOR)
end


module Toolkit
  VERSION = "2.5.1"
  DATE = "2014-07-24"
end