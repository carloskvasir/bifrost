# frozen_string_literal: true

source 'https://rubygems.org'

# Core dependencies (optimized for Lambda)
gem 'sinatra', '~> 3.0'
gem 'rack', '~> 2.2'
gem 'json', '~> 2.6'
gem 'webrick', '~> 1.8'  # Web server for development

# AWS Lambda Runtime Interface Client (for Ruby Lambda functions)
gem 'aws-sdk-lambda', '~> 1.80'

# Performance optimizations
gem 'oj', '~> 3.14'  # Fast JSON parsing/generation

# Development dependencies
group :development do
  gem 'rubocop', '~> 1.57'  # Code style checker
  gem 'solargraph', '~> 0.49'  # Language server for Ruby
end

# Testing dependencies
group :test do
  gem 'rspec', '~> 3.12'
  gem 'rack-test', '~> 2.1'
end

# Deployment dependencies (for Lambda packaging)
group :deployment do
  gem 'bundler', '~> 2.4'
end
