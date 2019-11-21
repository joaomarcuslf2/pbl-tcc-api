class AddSentToGroup < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :sent, :string
  end
end
