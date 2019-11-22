class AddReviewedToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :reviewed, :boolean, default: false
  end
end
