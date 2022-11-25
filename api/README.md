# Business::Api

Our Self Contained System encapsulating the Web API of our demo application

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

- /v1/products/:id

Where `id` must be a UUID:

```sh
curl -i localhost:9292/v1/products/f8f0434d-2b3a-44a5-aeed-0d973341b1cb
```

which produce a response as the follow:

```
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 45
Server: WEBrick/1.7.0 (Ruby/3.2.0/2022-11-15)
Date: Fri, 25 Nov 2022 10:28:29 GMT
Connection: Keep-Alive

{"id":"f8f0434d-2b3a-44a5-aeed-0d973341b1cb"}
```

If the ID is not a value with the structure of a UUID, it will respond with a
400 error and the reason the request was rejected:

```sh
curl -i localhost:9292/v1/products/12
```

Note how the response is a `Bad Request`:

```
HTTP/1.1 400 Bad Request
Content-Type: application/json
Content-Length: 41
Server: WEBrick/1.7.0 (Ruby/3.2.0/2022-11-15)
Date: Fri, 25 Nov 2022 10:31:34 GMT
Connection: Keep-Alive

{"reason":{"id":["is not a valid UUID"]}}
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/esparta/rubyconf2022.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the [code of conduct](https://github.com/esparta/rubyconf2022/blob/master/CODE_OF_CONDUCT.md).

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Business project's codebases, issue trackers, chat
rooms and mailing lists is expected to follow the [code of conduct](https://github.com/esparta/rubyconf2022/blob/master/CODE_OF_CONDUCT.md).
