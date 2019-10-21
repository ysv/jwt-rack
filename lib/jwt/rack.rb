# frozen_string_literal: true

require 'jwt/rack/version'

module JWT
  module Rack
    autoload :Auth,  'jwt/rack/auth'
    autoload :Token, 'jwt/rack/token'
  end
end
