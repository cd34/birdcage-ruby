# -*- encoding: utf-8 -*-
#$:.push File.expand_path("../lib", __FILE__)
Gem::Specification.new do |s|
  s.name        = 'birdcage'
  s.version     = '0.1.0'
  s.summary     = "Birdcage takes a number of Text objects and tries to construct the maximal length Phrase from the Text objects. Useful when trying to restrain tweet length."
  s.description = "This library allows you to send different length text items to generate a phrase. When the phrase is generated with a maximum length, the maximum length text items are selected."
  s.authors     = ["Chris Davies"]
  s.email       = 'email@example.com'
  s.files       = ["lib/birdcage.rb"]
  s.homepage    = 'http://rubygems.org/gems/birdcage'
  s.license     = 'MIT'
#  s.test_files = Dir.glob('test/tc_*.rb')
end
