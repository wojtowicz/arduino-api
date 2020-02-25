# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  render_views

  let(:thirty_seconds_ago) { 30.seconds.ago }
  let(:two_minutes_ago) { 2.minutes.ago }

  describe 'GET index' do
    it 'returns devices' do
      create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                      lng: '19.67', coords_label: 'Address, Poland')
      create(:device, name: 'Device 2', uuid: 'uuid2', lat: '51.7',
                      lng: '22.44', sync_at: two_minutes_ago,
                      coords_label: 'Address 2, Poland', wifi_ssid: 'SSID2',
                      local_ip: '192.168.1.2')
      create(:device, name: 'Device 3', uuid: 'uuid3', lat: '52.5',
                      lng: '34.78', sync_at: thirty_seconds_ago,
                      coords_label: 'Address 3, Poland',
                      wifi_ssid: 'SSID3', local_ip: '192.168.1.3')

      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        [
          {
            name: 'Device 1',
            uuid: 'uuid1',
            lat: '50.1',
            lng: '19.67',
            sync_at: nil,
            coords_label: 'Address, Poland',
            status: 'configuring',
            wifi_ssid: nil,
            local_ip: nil
          },
          {
            name: 'Device 2',
            uuid: 'uuid2',
            lat: '51.7',
            lng: '22.44',
            sync_at: two_minutes_ago,
            coords_label: 'Address 2, Poland',
            status: 'offline',
            wifi_ssid: 'SSID2',
            local_ip: '192.168.1.2'
          },
          {
            name: 'Device 3',
            uuid: 'uuid3',
            lat: '52.5',
            lng: '34.78',
            sync_at: thirty_seconds_ago,
            coords_label: 'Address 3, Poland',
            status: 'online',
            wifi_ssid: 'SSID3',
            local_ip: '192.168.1.3'
          }
        ].to_json
      )
    end
  end

  describe 'GET show' do
    let(:device) do
      create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                      lng: '19.67', coords_label: 'Address, Poland')
    end

    it 'returns device' do
      get :show, params: { uuid: device.uuid }, format: :json
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        {
          name: 'Device 1',
          uuid: 'uuid1',
          lat: '50.1',
          lng: '19.67',
          sync_at: nil,
          status: 'configuring',
          coords_label: 'Address, Poland',
          wifi_ssid: nil,
          local_ip: nil
        }.to_json
      )
    end
  end

  describe 'PUT update' do
    it 'updates exist device' do
      device = create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                               lng: '19.67', coords_label: 'Address, Poland')
      device_params = {
        name: 'My Device', lat: '1.1', lng: '2.2', coords_label: 'New Address',
        wifi_ssid: 'NEW WIFI SSID', local_ip: '192.168.1.1'
      }

      expect do
        put :update, params: { uuid: device.uuid, device: device_params },
                     format: :json
      end.to change(Device, :count).by(0)

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        {
          name: 'My Device',
          uuid: 'uuid1',
          lat: '1.1',
          lng: '2.2',
          sync_at: nil,
          coords_label: 'New Address',
          status: 'configuring',
          wifi_ssid: 'NEW WIFI SSID',
          local_ip: '192.168.1.1'
        }.to_json
      )
    end

    it 'creates new device' do
      device_params = { name: 'My Device' }

      expect do
        put :update, params: { uuid: 'uuid10', device: device_params },
                     format: :json
      end.to change(Device, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        {
          name: 'My Device',
          uuid: 'uuid10',
          lat: nil,
          lng: nil,
          sync_at: nil,
          coords_label: nil,
          status: 'configuring',
          wifi_ssid: nil,
          local_ip: nil
        }.to_json
      )
    end

    it 'validates device' do
      device_params = { name: '' }

      expect do
        put :update, params: { uuid: 'uuid10', device: device_params },
                     format: :json
      end.to change(Device, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to be_json_eql(
        {
          errors: {
            name: [
              error: 'blank',
              message: "can't be blank"
            ]
          }
        }.to_json
      )
    end
  end

  describe 'DELETE destroy' do
    it 'deletes device' do
      create(:device, uuid: 'uuid10')

      expect do
        delete :destroy, params: { uuid: 'uuid10' }, format: :json
      end.to change(Device, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
