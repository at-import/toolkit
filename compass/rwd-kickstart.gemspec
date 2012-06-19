# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  # General Project Information
  s.name = "rwd-kickstart"
  s.version = "1.0"
  s.date = "2011-06-19"
  s.rubyforge_project = "rwd-kickstart"
  s.rubygems_version = "1.7.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
  
  # Author Information
  s.authors = ["Sam Richard", "Mason Wendell"]
  s.email = ["sam@snug.ug", "mason@zivtech.com"]
  s.homepage = "https://github.com/Snugug/Aura"
  
  # Project Description
  s.description = "Responsive Framework utilizing Susy and Modular Scale."
  s.summary = "Responsive Framework for Compass."
  
  # Files to Include
  s.files = Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")
  s.files += Dir.glob("templates/**/*.*")
  
  # Dependent Gems
  s.add_dependency 'compass',             ">= 0.12.1" 
  s.add_dependency 'susy',                ">= 1.0.rc.0"
  s.add_dependency 'respond-to',          ">= 2.0"
end