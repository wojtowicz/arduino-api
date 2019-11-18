# frozen_string_literal: true

module Pollution
  module Airly
    class ApiClient
      API_KEY = Rails.application.credentials.fetch(:airly).fetch(:api_key)
      API_URL = 'https://airapi.airly.eu'

      def get(path, options = {})
        HTTParty.get("#{API_URL}/#{path}", request_options.merge(options))
      end

      private

      def request_options
        { headers: { apikey: API_KEY } }
      end
    end
  end
end
