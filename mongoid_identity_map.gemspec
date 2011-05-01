# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mongoid_identity_map/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongoid_identity_map"
  s.version     = MongoidIdentityMap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guilherme Cirne"]
  s.email       = ["gcirne@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/mongoid_identity_map"
  s.summary     = "IdentityMap for Mongoid"
  s.description = "Simple and transparent Identity Map implementation for Mongoid"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "mongoid_identity_map"

  s.add_dependency "activesupport", "~> 3.0.0"
  s.add_dependency "mongoid", "~> 2.0.0"

  s.add_development_dependency "bson_ext", ">= 1.3.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", ">= 2.5.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
