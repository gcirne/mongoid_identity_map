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

Add rack middleware `MongoidIdentityMap::ClearMiddleware` for clearing identity map after each request.

When using this gem in a Rails app this is done automatically.

## Current Limitations

Currently, it's an all or nothing deal. It is not possible to turn the identiy map on or off on a class (Mongoid::Document) basis.

Identity map is applied only on Mongoid's Collection find_one method. The find method doesn't have the identity map applied.
