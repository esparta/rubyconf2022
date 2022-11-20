Business Demo
=======

This is the demo repository for the talk in RubyConf 2022 titled:

> Never again without a contract: dry-validation


Context
-------

In order to make a close-to-real-life situation we will simulate a
new app having multiple _services_. Some of some these services would
have some parameters & payloads we will apply some basic enforcement
based on schemas (using Dry::Schema) or a contract (Dry::Validation).

Structure
-------

- business: This is place where we will host the most basic schemas & contracts
            via a gem, this gem will be used by the _services_ and extended by
            them if needed.

Installation
-------

TODO: Explain docker-compose

Build the container

```sh
docker-compose build
```

Get into the container & play around:

```sh
docker-compose run backend bash
```

Once you are inside the session, you can do most of the things

```sh
cd business
bundle exec rspec
```

You can also use the convenient Makefile:

```sh
docker-compose run backend make
```

or

```sh
docker-compose run backend make guard
```
