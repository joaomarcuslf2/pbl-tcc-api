class AddAssociationsToInscription < ActiveRecord::Migration[5.2]
  def change
    add_column :inscriptions, :user_id, :integer
    add_index  :inscriptions, :user_id

    add_column :inscriptions, :event_id, :integer
    add_index  :inscriptions, :event_id
  end
end
