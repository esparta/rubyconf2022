# Business::Web

Our Self Contained System main Web App

## Installation

First install the libraries needed

```sh
bundle install
```

Then just run the application using `rackup`:

```sh
bundle exec rackup
```

Our application will be executed on http://localhost:9292

## Usage

Just use any connector to request the data. The application has the following
endpoints:

- /
- /api/v1/products/:id

All the `api` namespace are contained on `Business::Api`, the gem located on the
[api](api) folder.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/esparta/rubyconf2022.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct](https://github.com/esparta/rubyconf2022/blob/main/CODE_OF_CONDUCT.md).

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Business project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of conduct](https://github.com/esparta/rubyconf2022/blob/main/CODE_OF_CONDUCT.md).
