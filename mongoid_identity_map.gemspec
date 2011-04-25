# -*- encoding: utf-8 -*-
require File.expand_path("../lib/mongoid/collection/identity_map/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "mongoid_identity_map"
  s.version     = Mongoid::Collection::IdentityMap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Guilherme Cirne"]
  s.email       = ["gcirne@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/mongoid_identity_map"
  s.summary     = "IdentityMap for Mongoid"
  s.description = "Simple and transparent IdentityMap implementation for Mongoid"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "mongoid_identity_map"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
