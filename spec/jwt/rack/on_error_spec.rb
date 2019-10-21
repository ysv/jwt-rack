# frozen_string_literal: true

require 'spec_helper'

describe JWT::Rack::Auth do
  let(:issuer)  { JWT::Rack::Token }
  let(:secret)  { 'secret' } # use 'secret to match hardcoded 'secret' @ http://jwt.io'
  let(:verify)  { true }
  let(:payload) { { foo: 'bar' } }

  let(:inner_app) do
    ->(env) { [200, env, [payload.to_json]] }
  end

  let(:app) { JWT::Rack::Auth.new(inner_app, secret: secret) }

  describe 'handles the exception' do
    before(:each) do
      header 'Authorization', "Bearer #{issuer.encode(payload, secret, 'HS256')}"
      get('/')
    end

    let(:on_error) do
      lambda do |error|
        message =
          if ::JWT::Rack::Auth::JWT_DECODE_ERRORS.include?(error.class)
            'Invalid JWT token'
          elsif error.is_a?(::JWT::Rack::Auth::MissingAuthHeader)
            'Missing Authorization header'
          elsif error.is_a?(::JWT::Rack::Auth::InvalidAuthHeaderFormat)
            'Invalid Authorization header format'
          end
        body    = { error: message }.to_json
        headers = { 'Content-Type' => 'application/json', 'Content-Length' => body.bytesize.to_s }

        [401, headers, [body]]
      end
    end

    let(:app) { JWT::Rack::Auth.new(inner_app, secret: 'secret', on_error: on_error) }

    describe '::JWT::VerificationError' do
      let(:inner_app) { ->(_env) { raise ::JWT::VerificationError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::ExpiredSignature' do
      let(:inner_app) { ->(_env) { raise ::JWT::ExpiredSignature } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::IncorrectAlgorithm' do
      let(:inner_app) { ->(_env) { raise ::JWT::IncorrectAlgorithm } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::ImmatureSignature' do
      let(:inner_app) { ->(_env) { raise ::JWT::ImmatureSignature } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::InvalidIssuerError' do
      let(:inner_app) { ->(_env) { raise ::JWT::InvalidIssuerError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::InvalidIatError' do
      let(:inner_app) { ->(_env) { raise ::JWT::InvalidIatError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::InvalidAudError' do
      let(:inner_app) { ->(_env) { raise ::JWT::InvalidAudError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::InvalidSubError' do
      let(:inner_app) { ->(_env) { raise ::JWT::InvalidSubError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::InvalidJtiError' do
      let(:inner_app) { ->(_env) { raise ::JWT::InvalidJtiError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::DecodeError' do
      let(:inner_app) { ->(_env) { raise ::JWT::DecodeError } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid JWT token')
      end
    end

    describe '::JWT::Rack::Auth::MissingAuthHeader' do
      let(:inner_app) { ->(_env) { raise ::JWT::Rack::Auth::MissingAuthHeader } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Missing Authorization header')
      end
    end

    describe '::JWT::Rack::Auth::InvalidAuthHeaderFormat' do
      let(:inner_app) { ->(_env) { raise ::JWT::Rack::Auth::InvalidAuthHeaderFormat } }

      it 'returns a 401 and the correct error msg' do
        expect(last_response.status).to eq 401
        body = JSON.parse(last_response.body, symbolize_names: true)
        expect(body).to eq(error: 'Invalid Authorization header format')
      end
    end
  end
end
