if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end

module Toolkit
  VERSION = "2.1.0"
  DATE = "2014-03-27"
end