class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :content
      t.date :calendar_date

      t.timestamps
    end
  end
end
