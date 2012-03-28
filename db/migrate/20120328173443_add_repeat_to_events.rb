class AddRepeatToEvents < ActiveRecord::Migration
  def change
    add_column :events, :repeat, :integer, :default => 0

  end
end
