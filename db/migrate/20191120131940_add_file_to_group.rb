class AddFileToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :file, :string
  end
end
