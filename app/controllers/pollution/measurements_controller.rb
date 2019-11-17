module Pollution
  class MeasurementsController < ApplicationController
    def index
      @presenter = Pollution::MeasurementsPresenter.new(lat: lat_param, lng: lng_param, fields: params[:fields])
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
