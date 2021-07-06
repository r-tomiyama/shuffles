class ShuffleList < ApplicationRecord
  belongs_to :user
  has_many :shuffle_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :have_2_or_more_items

  def have_2_or_more_items
    errors.add(:base, 'シャッフル要素は2個以上必要です') if shuffle_items.size < 2
  end
end
