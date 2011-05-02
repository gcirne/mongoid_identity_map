Mongoid Identity Map
====================

## About [![Build Status](http://travis-ci.org/gcirne/mongoid_identity_map.png)](http://travis-ci.org/gcirne/mongoid_identity_map)

Mongoid Identity Map is a simple and transparent Identity Map implementation for the Mongoid ODM.

[Mongoid](http://mongoid.org)

[Identity Map pattern](http://martinfowler.com/eaaCatalog/identityMap.html)

## Installation

In Gemfile:

    gem "mongoid_identity_map"

## Configuration

Add rack middleware for clearing identity map after each request.

In Rails add the following to environment.rb or to environment specific file:

    config.middleware.use MongoidIdentityMap::ClearMiddleware

## Current Limitations

Currently, it's an all or nothing deal. It is not possible to turn the identiy map on or off on a class (Mongoid::Document) basis.

Identity map is applied only on Mongoid's Collection find_one method. The find method doesn't have the identity map applied.
