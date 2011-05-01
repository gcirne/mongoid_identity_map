About
=====

Mongoid Identity Map is a simple and transparent Identity Map implementation for the Mongoid ODM.

[Mongoid](http://mongoid.org)

[Identity Map pattern](http://martinfowler.com/eaaCatalog/identityMap.html)

Installation
============

Install gem
-----------

In Gemfile:

    gem "mongoid_identity_map"

Add rack middleware for clearing identity map after each request
----------------------------------------------------------------

In Rails :

    config.middleware.use MongoidIdentityMap::ClearMiddleware

Current Limitations
===================

Contributing
============
