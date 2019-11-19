class CreateRequisiteEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :requisite_events do |t|
      t.integer :weight
      t.timestamps
    end
  end
end
