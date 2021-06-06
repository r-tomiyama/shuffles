class CreateShuffleLists < ActiveRecord::Migration[5.1]
  def change
    create_table :shuffle_lists do |t|
      t.string :name, unique: true, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
