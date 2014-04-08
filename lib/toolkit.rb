if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end

module Toolkit
  VERSION = "2.3.0"
  DATE = "2014-04-07"
end