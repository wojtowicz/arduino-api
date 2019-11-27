# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :devices do |t|
      t.string :uuid, null: false, index: { unique: true }
      t.string :lat
      t.string :lng
      t.string :encrypted_airly_api_key
      t.string :encrypted_airly_api_key_iv

      t.timestamps
    end
  end
end
