# frozen_string_literal: true

class AddNameToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :name, :string, null: false
  end
end
