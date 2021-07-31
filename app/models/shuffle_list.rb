class ShuffleList < ApplicationRecord
  belongs_to :user
  has_many :shuffle_items, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validate :have_2_or_more_items
  validate :forbid_same_items

  def have_2_or_more_items
    errors.add(:shuffle_items, :require_2_or_more) if shuffle_items.size < 2
  end

  def forbid_same_items
    if (shuffle_items.length - shuffle_items.map(&:name).uniq.count) > 0
      errors.add(:shuffle_items, :forbid_same_items)
    end
  end
end
