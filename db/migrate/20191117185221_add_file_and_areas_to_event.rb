class AddFileAndAreasToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :file, :string
    add_column :events, :areas, :string
  end
end
