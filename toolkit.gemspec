require './lib/toolkit'

Gem::Specification.new do |s|
  # Release Specific Information
  s.version = Toolkit::VERSION
  s.date = Toolkit::DATE

  # General Project Information
  s.name = "toolkit"
  s.rubyforge_project = "toolkit"
  s.rubygems_version = "1.7.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 1.2")
  s.licenses = ['MIT', 'GPL-2.0']

  # Author Information
  s.authors = ["Sam Richard", "Scott Kellum", "Mason Wendell"]
  s.email = ["sam@snug.ug", "scott@scottkellum.com", "mason@zivtech.com"]
  s.homepage = "https://github.com/Snugug/toolkit"

  # Project Description
  s.description = "Toolkit full of bits and bobs of awesome aimed at assisting in advanced styling with Sass"
  s.summary = "Toolkit of awesome Sass stuff"

  # Files to Include
  s.files = ["README.md"]
  s.files += ["CHANGELOG.md"]
  s.files += Dir.glob("LICENSE.txt")
  s.files = Dir.glob("lib/**/*.*")
  s.files += Dir.glob("stylesheets/**/*.*")


  # Dependent Gems
  s.add_dependency("sass",      ["~>3.3"])
end
