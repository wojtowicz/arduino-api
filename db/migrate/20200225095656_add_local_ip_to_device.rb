# frozen_string_literal: true

class AddLocalIpToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :local_ip, :string
  end
end
