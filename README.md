Business Demo
=======

This is the demo repository for the talk in RubyConf 2022 titled:

> Never again without a contract: dry-validation


Context
-------

In order to make a close-to-real-life situation we will simulate a
new app having multiple _services_. Some of some these services would
have some parameters & payloads we will apply some basic enforcement
based on schemas (using `Dry::Schema`) or a contract (`Dry::Validation`).

Structure
-------

- [business](business): This is place where we will host the most basic schemas
           & contracts via a gem, this gem will be used by the _services_ and 
           extended by them if needed.

- [api](api): The self-contained gem `Business::Api` having a minimal set of
           endpoints which will be using the schemas & contracts exposed on
           **business** gem.

- [web](web): The main web application exposing some endpoint, one of them, the
           `api` scope is actually the `Business::Api` gem.

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

## Development

After checking out the repo, run `bundle install` to install dependencies. Then,
run `rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/esparta/rubyconf2022.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct](https://github.com/esparta/rubyconf2022/blob/main/CODE_OF_CONDUCT.md).

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Business project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of conduct](https://github.com/esparta/rubyconf2022/blob/main/CODE_OF_CONDUCT.md).
