# OmniAuth Scalus

Scalus OAuth2 Strategy for OmniAuth 1.0.

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-scalus-oauth2'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::Scalus` is simply a Rack middleware. Read [the OmniAuth 1.0 docs](https://github.com/intridea/omniauth) for detailed instructions.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :scalus, ENV['SCALUS_API_KEY'], ENV['SCALUS_SHARED_SECRET']
end
```

## Configuring

You can configure the scope, which you pass in to the `provider` method via a `Hash`:

* `scope`: A comma-separated list of permissions you want to request from the user. See [the Scalus API docs](http://docs.scalus.com/api/tutorials/oauth) for a full list of available permissions.

For example, to request `read_products`, `read_orders` and `write_content` permissions and display the authentication page:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :scalus, ENV['SCALUS_API_KEY'], ENV['SCALUS_SHARED_SECRET'], :scope => 'read_products,read_orders,write_content'
end
```

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'scalus',
  :uid => 'example_slug.scalus.com', # example\_slug is the organization's subdomain
  :credentials => {
    :token => 'afasd923kjh0934kf', # OAuth 2.0 access_token, which you store and use to authenticate API requests
  }
}
```

## License

Copyright (c) 2015 by Scalus Inc

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
