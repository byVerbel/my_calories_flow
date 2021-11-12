class Calorie < ApplicationRecord
  belongs_to :user
  validates :ammount, presence: true, length: { maximum: 4 }
  validates :register_type, presence: true, length: { maximum: 6 }, inclusion: { in: %w[Gained Burned] }
  validates :register_comment, length: { maximum: 140 }
end
