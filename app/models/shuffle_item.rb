class ShuffleItem < ApplicationRecord
  belongs_to :shuffle_list

  validates :name, presence: true
end
