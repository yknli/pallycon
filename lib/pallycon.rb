# frozen_string_literal: true

require 'base64'
require 'openssl'
require 'json'
require 'digest'

require_relative "pallycon/version"
require_relative "pallycon/configuration"
require_relative "pallycon/drm"
require_relative "pallycon/license_token/policy"
require_relative "pallycon/license_token/attributes"
require_relative "pallycon/license_token/generator"

module Pallycon
  class Error < StandardError; end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    # Set configurations in your application:
    # Pallycon.configure do |config|
    #   config.site_id = "<your_site_id>"
    #   config.site_key = "<your_site_key>"
    #   config.site_access_key = "<your_site_access_key>"
    # end
    def configure
      yield(configuration)
    end
  end
end
