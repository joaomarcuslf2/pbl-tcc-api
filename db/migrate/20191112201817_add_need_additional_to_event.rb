class AddNeedAdditionalToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :need_additional, :boolean, :null => false, :default => false
  end
end
