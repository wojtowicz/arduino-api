# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  render_views

  describe 'GET index' do
    it 'returns devices' do
      create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                      lng: '19.67')
      create(:device, name: 'Device 2', uuid: 'uuid2', lat: '51.7',
                      lng: '22.44',
                      sync_at: DateTime.new(2012, 8, 29, 12, 34, 56))
      create(:device, name: 'Device 3', uuid: 'uuid3', lat: '52.5',
                      lng: '34.78')

      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        [
          {
            name: 'Device 1',
            uuid: 'uuid1',
            lat: '50.1',
            lng: '19.67',
            sync_at: nil
          },
          {
            name: 'Device 2',
            uuid: 'uuid2',
            lat: '51.7',
            lng: '22.44',
            sync_at: '2012-08-29T12:34:56.000Z'
          },
          {
            name: 'Device 3',
            uuid: 'uuid3',
            lat: '52.5',
            lng: '34.78',
            sync_at: nil
          }
        ].to_json
      )
    end
  end

  describe 'GET show' do
    let(:device) do
      create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                      lng: '19.67')
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
          sync_at: nil
        }.to_json
      )
    end
  end

  describe 'PUT update' do
    it 'updates exist device' do
      device = create(:device, name: 'Device 1', uuid: 'uuid1', lat: '50.1',
                               lng: '19.67')
      device_params = { name: 'My Device', lat: '1.1', lng: '2.2' }

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
          sync_at: nil
        }.to_json
      )
    end

    it 'creates new device' do
      device_params = { name: 'My Device', lat: '1.1', lng: '2.2' }

      expect do
        put :update, params: { uuid: 'uuid10', device: device_params },
                     format: :json
      end.to change(Device, :count).by(1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_eql(
        {
          name: 'My Device',
          uuid: 'uuid10',
          lat: '1.1',
          lng: '2.2',
          sync_at: nil
        }.to_json
      )
    end

    it 'validates device' do
      device_params = { name: '', lat: '1.1', lng: '2.2' }

      expect do
        put :update, params: { uuid: 'uuid10', device: device_params },
                     format: :json
      end.to change(Device, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to be_json_eql(
        {
          name: ["can't be blank"]
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
