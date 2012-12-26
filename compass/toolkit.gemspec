# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  # General Project Information
  s.name = "toolkit"
  s.version = "0.2.2"
  s.date = "2011-12-26"
  s.rubyforge_project = "toolkit"
  s.rubygems_version = "1.7.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")

  # Author Information
  s.authors = ["Sam Richard", "Scott Kellum", "Mason Wendell"]
  s.email = ["sam@snug.ug", "scott@scottkellum.com", "mason@zivtech.com"]
  s.homepage = "https://github.com/Snugug/toolkit"

  # Project Description
  s.description = "Toolkit for Progressive Enhancement and Responsive Web Design"
  s.summary = "Progressive Enhancement and RWD toolkit of awesomeness"

  # Files to Include
  s.files = Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")
  s.files += Dir.glob("templates/**/*.*")
  s.files += Dir.glob("LICENSE.txt")

  # Dependent Gems
  s.add_dependency 'compass',             ">= 0.12.2"
  s.add_dependency 'susy',                ">= 1.0.5"
  s.add_dependency 'respond-to',          ">= 2.6"
  s.add_dependency 'singularitygs',       ">= 0.0.17"
end