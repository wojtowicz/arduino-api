# frozen_string_literal: true

class AddWifiSsidToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :wifi_ssid, :string
  end
end
