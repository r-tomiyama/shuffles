class ShuffleItem < ApplicationRecord
  belongs_to :shuffle_list

  validates :name, presence: true
  validates_uniqueness_of :name, uniquness: { scope: [:shuffle_list_id] } # TODO: 思ったように聞いてなさそう
end
