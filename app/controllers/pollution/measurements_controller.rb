# frozen_string_literal: true

module Pollution
  class MeasurementsController < ApplicationController
    def index
      @presenter = Pollution::MeasurementsPresenter.new(
        lat: lat_param, lng: lng_param, fields: params[:fields]
      )
      data = "DATA:#{@presenter.to_text}"
      response.headers['Content-Length'] = data.length
      send_data(data, filename: 'measurements.txt')
    end

    private

    def lat_param
      params.require(:lat)
    end

    def lng_param
      params.require(:lng)
    end
  end
end
