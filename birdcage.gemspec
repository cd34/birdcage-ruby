# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = "birdcage"
  s.version     = "0.1.0"
  s.summary     = "Construct maximal length phrases from variable-length text objects"
  s.description = "This library allows you to send different length text items to generate a phrase. " \
                  "When the phrase is generated with a maximum length, the maximum length text items are selected."
  s.authors     = ["Chris Davies"]
  s.email       = "email@example.com"
  s.files       = Dir["lib/**/*.rb"]
  s.homepage    = "https://rubygems.org/gems/birdcage"
  s.license     = "MIT"
  s.required_ruby_version = ">= 3.0"

  s.metadata["homepage_uri"] = s.homepage
end
