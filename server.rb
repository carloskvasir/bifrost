#!/usr/bin/env ruby
# frozen_string_literal: true

# Bifronst - A Magical Bridge Server (Optimized for AWS Lambda)
# Inspired by the Bifrost from Norse mythology
# This server acts as a bridge between different worlds (systems)

require 'sinatra/base'
require 'json'

# Bifronst Application Class
class BifronstApp < Sinatra::Base
  # Configure Sinatra for Lambda optimization
  set :environment, ENV.fetch('RACK_ENV', 'production').to_sym
  set :port, ENV.fetch('PORT', 3000).to_i
  set :bind, '0.0.0.0'
  set :static, false
  set :static_cache_control, [:public, :max_age => 86400]
  set :logging, true
  set :dump_errors, false
  set :raise_errors, false
  set :show_exceptions, false

  # Middleware for logging requests (optimized for Lambda)
  before do
    logger.level = Logger::INFO
    logger.info "#{request.request_method} #{request.path_info} from #{request.ip}"
  end

  # Root endpoint - Welcome to Bifronst
  get '/' do
    content_type :json
    {
      message: 'Welcome to Bifronst, the magical bridge!',
      description: 'A bridge between worlds, connecting systems and ideas.',
      version: '1.0.0',
      environment: settings.environment.to_s,
      endpoints: {
        status: '/status',
        helloworld: '/helloworld',
        ping: '/ping',
        bifronst: '/bifronst'
      }
    }.to_json
  end

  # Status endpoint - Health check
  get '/status' do
    content_type :text
    'ok'
  end

  # Hello World endpoint - JSON response demo
  get '/helloworld' do
    content_type :json
    { message: 'hello world' }.to_json
  end

  # Ping endpoint - Connectivity test (useful for Discord bots)
  get '/ping' do
    content_type :text
    'pong'
  end

  # Bifronst endpoint - Special bridge information
  get '/bifronst' do
    content_type :json
    {
      bridge: 'Bifronst',
      mythology: 'Norse',
      purpose: 'Connect Asgard and Midgard',
      digital_purpose: 'Connect systems and facilitate communication',
      status: 'Active',
      magic_level: 'High',
      runtime: 'AWS Lambda',
      created_at: Time.now.iso8601
    }.to_json
  end

  # Error handling
  error 404 do
    content_type :json
    status 404
    {
      error: 'Bridge not found',
      message: 'The path you seek does not exist on this bridge',
      suggestion: 'Try /status, /helloworld, /ping, or /bifronst'
    }.to_json
  end

  error 500 do
    content_type :json
    status 500
    {
      error: 'Bridge malfunction',
      message: 'Something went wrong on the magical bridge',
      suggestion: 'Please try again later'
    }.to_json
  end

  # Health check for load balancers
  get '/health' do
    content_type :json
    {
      status: 'healthy',
      timestamp: Time.now.iso8601,
      uptime: Process.clock_gettime(Process::CLOCK_MONOTONIC)
    }.to_json
  end
end

# Lambda Handler Function (for AWS Lambda deployment)
def lambda_handler(event:, context:)
  # Parse the incoming event
  path = event.dig('requestContext', 'http', 'path') || event['path'] || '/'
  method = event.dig('requestContext', 'http', 'method') || event['httpMethod'] || 'GET'
  headers = event['headers'] || {}
  body = event['body'] || ''

  # Create Rack environment
  env = {
    'REQUEST_METHOD' => method,
    'PATH_INFO' => path,
    'QUERY_STRING' => event['queryStringParameters']&.map { |k, v| "#{k}=#{v}" }&.join('&') || '',
    'CONTENT_TYPE' => headers['content-type'] || 'application/json',
    'CONTENT_LENGTH' => body.length.to_s,
    'rack.input' => StringIO.new(body),
    'rack.errors' => StringIO.new,
    'rack.logger' => Logger.new($stdout),
    'rack.url_scheme' => 'https'
  }

  # Add headers to environment
  headers.each do |key, value|
    env["HTTP_#{key.upcase.tr('-', '_')}"] = value
  end

  # Process request through Sinatra
  status, response_headers, response_body = BifronstApp.call(env)

  # Format response for Lambda
  {
    statusCode: status,
    headers: response_headers,
    body: response_body.join
  }
end

# For local development (not Lambda)
if __FILE__ == $0
  puts '🌈 Bifronst bridge is now active!'
  puts '🌉 Connecting worlds through the power of code...'
  puts '📡 Available endpoints: /status, /helloworld, /ping, /bifronst, /health'
  puts "🚀 Running on #{BifronstApp.settings.environment} environment"

  BifronstApp.run!
end
