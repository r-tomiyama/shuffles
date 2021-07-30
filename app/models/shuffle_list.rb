class ShuffleList < ApplicationRecord
  belongs_to :user
  has_many :shuffle_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :have_2_or_more_items

  def have_2_or_more_items
    errors.add(:shuffle_items, :require_2_or_more) if shuffle_items.size < 2
  end
end
