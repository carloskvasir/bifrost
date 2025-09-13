# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BifronstApp do
  describe 'GET /' do
    it 'returns welcome message' do
      get '/'

      expect(last_response).to be_ok
      response_body = JSON.parse(last_response.body)

      expect(response_body['message']).to include('Welcome to Bifronst')
      expect(response_body['endpoints']).to be_a(Hash)
    end
  end

  describe 'GET /status' do
    it 'returns ok' do
      get '/status'

      expect(last_response).to be_ok
      expect(last_response.body).to eq('ok')
      expect(last_response.content_type).to eq('text/plain')
    end
  end

  describe 'GET /helloworld' do
    it 'returns hello world JSON' do
      get '/helloworld'

      expect(last_response).to be_ok
      response_body = JSON.parse(last_response.body)

      expect(response_body['message']).to eq('hello world')
    end
  end

  describe 'GET /ping' do
    it 'returns pong' do
      get '/ping'

      expect(last_response).to be_ok
      expect(last_response.body).to eq('pong')
      expect(last_response.content_type).to eq('text/plain')
    end
  end

  describe 'GET /bifronst' do
    it 'returns bridge information' do
      get '/bifronst'

      expect(last_response).to be_ok
      response_body = JSON.parse(last_response.body)

      expect(response_body['bridge']).to eq('Bifronst')
      expect(response_body['mythology']).to eq('Norse')
      expect(response_body['status']).to eq('Active')
    end
  end

  describe 'GET /health' do
    it 'returns health status' do
      get '/health'

      expect(last_response).to be_ok
      response_body = JSON.parse(last_response.body)

      expect(response_body['status']).to eq('healthy')
      expect(response_body).to have_key('timestamp')
      expect(response_body).to have_key('uptime')
    end
  end

  describe 'GET /nonexistent' do
    it 'returns 404 error' do
      get '/nonexistent'

      expect(last_response.status).to eq(404)
      response_body = JSON.parse(last_response.body)

      expect(response_body['error']).to eq('Bridge not found')
      expect(response_body['suggestion']).to include('/status')
    end
  end
end
