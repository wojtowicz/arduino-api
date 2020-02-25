# frozen_string_literal: true

class RemoveEncryptedAirlyApiKeyFromDevice < ActiveRecord::Migration[6.0]
  def change
    remove_column :devices, :encrypted_airly_api_key, :string
    remove_column :devices, :encrypted_airly_api_key_iv, :string
  end
end
