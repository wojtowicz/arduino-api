# frozen_string_literal: true

class AddCoordsLabelToDevice < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :coords_label, :string
  end
end
