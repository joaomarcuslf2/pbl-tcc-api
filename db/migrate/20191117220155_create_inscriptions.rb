class CreateInscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :inscriptions do |t|

      t.timestamps
    end
  end
end
