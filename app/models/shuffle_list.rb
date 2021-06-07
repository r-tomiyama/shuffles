class ShuffleList < ApplicationRecord
  belongs_to :user
  has_many :shuffle_items

  validates :name, presence: true, uniqueness: true
  # TODO: item0個の場合に保存できないようにする
end
