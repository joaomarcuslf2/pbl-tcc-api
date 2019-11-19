class AddAssociationToRequisite < ActiveRecord::Migration[5.2]
  def change
    add_column :requisite_events, :event_id, :integer
    add_index  :requisite_events, :event_id

    add_column :requisite_events, :requisite_id, :integer
    add_index  :requisite_events, :requisite_id
  end
end
