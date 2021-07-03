class ShuffleList < ApplicationRecord
  belongs_to :user
  has_many :shuffle_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  # TODO: item0個の場合に保存できないようにする
  # TODO: 同一list内でユニーク制約をつける
end
