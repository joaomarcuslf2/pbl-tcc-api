class CreatePills < ActiveRecord::Migration[5.2]
  def change
    create_table :pills do |t|
      t.string :title
      t.text :content
      t.integer :min
      t.integer :max
      t.timestamps
    end
  end
end
