Mongoid Identity Map
====================

## Deprecated

Mongoid now has its own identity map. This project has been deprecated.

## About [![Build Status](http://travis-ci.org/gcirne/mongoid_identity_map.png)](http://travis-ci.org/gcirne/mongoid_identity_map)

Mongoid Identity Map is a simple and transparent Identity Map implementation for the Mongoid ODM.

[Mongoid](http://mongoid.org)

[Identity Map pattern](http://martinfowler.com/eaaCatalog/identityMap.html)

## Installing

In Gemfile:

    gem "mongoid_identity_map"

## Using

Identity map is applied automatically to all queries that return a single model.

## Clearing the identity map

A rack middleware - `MongoidIdentityMap::ClearMiddleware` - is provided for clearing the identity map after each request. In a Rails app, this middleware is automatically added to the list of middlewares.

You can also clear the identity map by calling `MongoidIdentityMap::IdentityMap.clear`.

## Current limitations

Currently, it's an all or nothing deal. It is not possible to turn the identiy map on or off on a class (Mongoid::Document) basis.

Identity map is applied only on queries that return a single model. Queries that return a cursor are not affected.
