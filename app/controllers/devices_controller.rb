# frozen_string_literal: true

class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find_by!(uuid: params[:uuid])
  end

  def update
    @device = Device.find_or_initialize_by(uuid: params[:uuid])
    @device.update(device_params)
    respond_with @device
  end

  def destroy
    device = Device.find_by!(uuid: params[:uuid])
    device.destroy
    head :no_content
  end

  private

  def device_params
    params.require(:device).permit(
      :lat, :lng, :name, :sync_at, :airly_api_key, :coords_label
    )
  end
end
