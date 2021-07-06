class AddIndexToShuffleItems < ActiveRecord::Migration[5.1]
  def change
    add_index :shuffle_items, %i[shuffle_list_id name], unique: true
  end
end
