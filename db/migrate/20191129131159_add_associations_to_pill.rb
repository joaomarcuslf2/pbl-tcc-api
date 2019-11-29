class AddAssociationsToPill < ActiveRecord::Migration[5.2]
  def change
    add_column :pills, :requisite_id, :integer
    add_index  :pills, :requisite_id
  end
end
