# frozen_string_literal: true

class AddSyncAtToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :sync_at, :datetime
  end
end
