class ShuffleItem < ApplicationRecord
  belongs_to :shuffle_list

  validates :name, presence: true
  validates :name, uniqueness: { scope: :shuffle_list_id }
end
