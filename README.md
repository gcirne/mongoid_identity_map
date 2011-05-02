Mongoid Identity Map
====================

About
-----

Mongoid Identity Map is a simple and transparent Identity Map implementation for the Mongoid ODM.

[Mongoid](http://mongoid.org)

[Identity Map pattern](http://martinfowler.com/eaaCatalog/identityMap.html)

Installation
------------

In Gemfile:

    gem "mongoid_identity_map"

Configuration
-------------

Add rack middleware for clearing identity map after each request.

In Rails add the following to environment.rb or to environment specific file:

    config.middleware.use MongoidIdentityMap::ClearMiddleware

Current Limitations
-------------------

Contributing
------------
