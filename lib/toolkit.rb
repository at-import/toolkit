if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end

module Toolkit
  VERSION = "2.5.0"
  DATE = "2014-06-25"
end