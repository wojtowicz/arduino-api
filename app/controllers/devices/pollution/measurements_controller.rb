# frozen_string_literal: true

module Devices
  module Pollution
    class MeasurementsController < ApplicationController
      def index
        authorize device, :measurements?

        device.touch(:sync_at)

        @presenter = build_presenter

        respond_to do |format|
          format.json
          format.text { text_response }
        end
      end

      private

      def device
        @device ||= Device.find_by!(uuid: params[:device_uuid])
      end

      def build_presenter
        ::Pollution::MeasurementsPresenter.new(
          lat: device.lat, lng: device.lng, fields: params[:fields],
          cached: true
        )
      end

      def text_response
        data = "DATA:#{@presenter.to_text}"
        response.headers['Content-Length'] = data.length
        send_data(data, filename: 'measurements.txt')
      end
    end
  end
end
