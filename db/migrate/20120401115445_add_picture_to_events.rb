class AddPictureToEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.has_attached_file :picture
    end
  end
end
