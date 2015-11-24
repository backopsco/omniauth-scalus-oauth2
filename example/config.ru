require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-scalus-oauth2'

SCOPE = 'read_products,read_orders,read_customers,write_shipping'
SCALUS_API_KEY = ENV['SCALUS_API_KEY']
SCALUS_SHARED_SECRET = ENV['SCALUS_SHARED_SECRET']

unless SCALUS_API_KEY && SCALUS_SHARED_SECRET
  abort("SCALUS_API_KEY and SCALUS_SHARED_SECRET environment variables must be set")
end

class App < Sinatra::Base
  get '/' do
    <<-HTML
    <html>
    <head>
      <title>Scalus Oauth2</title>
    </head>
    <body>
      <form action="/auth/scalus" method="get">
      <label for="organization">Enter your Scalus Subdomain:</label>
      <input type="text" name="organization" placeholder="your-scalus-url.scalus.com">
      <button type="submit">Log In</button>
      </form>
    </body>
    </html>
    HTML
  end

  get '/auth/:provider/callback' do
    <<-HTML
    <html>
    <head>
      <title>Scalus Oauth2</title>
    </head>
    <body>
      <h3>Authorized</h3>
      <p>Organization: #{request.env['omniauth.auth'].uid}</p>
      <p>Token: #{request.env['omniauth.auth']['credentials']['token']}</p>
    </body>
    </html>
    HTML
  end

  get '/auth/failure' do
    <<-HTML
    <html>
    <head>
      <title>Scalus Oauth2</title>
    </head>
    <body>
      <h3>Failed Authorization</h3>
      <p>Message: #{params[:message]}</p>
    </body>
    </html>
    HTML
  end
end

use Rack::Session::Cookie, secret: SecureRandom.hex(64)

use OmniAuth::Builder do
  provider :scalus, SCALUS_API_KEY, SCALUS_SHARED_SECRET, :scope => SCOPE
end

run App.new
