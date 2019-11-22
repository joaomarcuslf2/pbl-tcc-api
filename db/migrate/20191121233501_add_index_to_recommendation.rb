class AddIndexToRecommendation < ActiveRecord::Migration[5.2]
  def change
    add_column :recommendations, :user_id, :integer
    add_index  :recommendations, :user_id

    add_column :recommendations, :event_id, :integer
    add_index  :recommendations, :event_id

    add_column :recommendations, :requisite_id, :integer
    add_index  :recommendations, :requisite_id

    add_column :recommendations, :author, :string
  end
end
