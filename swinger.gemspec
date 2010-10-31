# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "swinger"
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jeff Kreeftmeijer']
  s.email       = ['jeff@kreeftmeijer.nl']
  s.homepage    = "http://rubygems.org/gems/swinger"
  s.summary     = %q{Capybara Driver swapping in RSpec}
  s.description = %q{Swinger is a really simple Capybara extension that allows your Capybara to have multiple partners in one session.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('rspec', [">= 1.0.0"])
  s.add_dependency('capybara', ["~> 0.3.0"])
end
