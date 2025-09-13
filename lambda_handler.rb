#!/usr/bin/env ruby
# frozen_string_literal: true

# AWS Lambda Handler for Bifronst
# This file contains the Lambda function handler optimized for serverless deployment

require_relative 'server'

# Lambda Handler Function
# This function is called by AWS Lambda when the function is invoked
def lambda_handler(event:, context:)
  # Log the invocation for monitoring
  puts "Bifronst Lambda invoked at #{Time.now.iso8601}"

  # Call the handler from server.rb
  lambda_handler(event: event, context: context)
end

# For local testing (when not running in Lambda)
if __FILE__ == $0
  puts '🧪 Testing Bifronst Lambda handler locally...'

  # Sample event for testing
  test_event = {
    'requestContext' => {
      'http' => {
        'path' => '/',
        'method' => 'GET'
      }
    },
    'headers' => {
      'content-type' => 'application/json'
    },
    'body' => ''
  }

  # Mock context
  test_context = {
    'aws_request_id' => 'test-request-id',
    'function_name' => 'bifronst-lambda'
  }

  # Test the handler
  begin
    result = lambda_handler(event: test_event, context: test_context)
    puts '✅ Lambda handler test successful!'
    puts "Response: #{result}"
  rescue => e
    puts "❌ Lambda handler test failed: #{e.message}"
    puts e.backtrace
  end
end
