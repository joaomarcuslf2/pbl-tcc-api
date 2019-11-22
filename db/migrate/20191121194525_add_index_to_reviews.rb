class AddIndexToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :user_id, :integer
    add_index  :reviews, :user_id

    add_column :reviews, :event_id, :integer
    add_index  :reviews, :event_id

    add_column :reviews, :requisite_id, :integer
    add_index  :reviews, :requisite_id

    add_column :reviews, :value, :integer
    add_column :reviews, :weight, :integer
  end
end
