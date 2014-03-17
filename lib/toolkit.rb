if (defined? Compass)
  Compass::Frameworks.register(
    "toolkit",
    :path => "#{File.dirname(__FILE__)}/.."
  )
end

module Toolkit
  VERSION = "2.0.1"
  DATE = "2014-03-17"
end