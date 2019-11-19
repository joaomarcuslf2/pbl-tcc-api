class AddGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :rate, :integer

    add_column :groups, :event_id, :integer
    add_index  :groups, :event_id

    add_column :inscriptions, :group_id, :integer
    add_index  :inscriptions, :group_id
  end
end
