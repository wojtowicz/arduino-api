# frozen_string_literal: true

module Devices
  module Pollution
    class MeasurementsController < ApplicationController
      def index
        device = Device.find_by!(uuid: params[:device_uuid])
        device.touch(:sync_at)

        @presenter = build_presenter

        respond_to do |format|
          format.json
          format.text { text_response }
        end
      end

      private

      def build_presenter
        ::Pollution::MeasurementsPresenter.new(
          lat: lat_param, lng: lng_param, fields: params[:fields], cached: true
        )
      end

      def text_response
        data = "DATA:#{@presenter.to_text}"
        response.headers['Content-Length'] = data.length
        send_data(data, filename: 'measurements.txt')
      end

      def lat_param
        params.require(:lat)
      end

      def lng_param
        params.require(:lng)
      end
    end
  end
end
