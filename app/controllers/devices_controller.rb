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

    respond_to do |format|
      if @device.update(device_params)
        format.json { render :show }
      else
        format.json do
          render json: @device.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    device = Device.find_by!(uuid: params[:uuid])
    device.destroy
    head :no_content
  end

  private

  def device_params
    params.require(:device).permit(:lat, :lng, :name, :sync_at, :airly_api_key)
  end
end
