class CreateShuffleItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shuffle_items do |t|
      t.string :name, null: false
      t.references :shuffle_list, foreign_key: true

      t.timestamps
    end
  end
end
