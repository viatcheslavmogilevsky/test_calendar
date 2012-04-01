class AddIndexToEvents < ActiveRecord::Migration
  def change
    add_index :events, :repeat
  end
end
