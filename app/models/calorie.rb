class Calorie < ApplicationRecord
  belongs_to :user
  validates :ammount, presence: true, length: { maximum: 4 }
  validates :register_type, presence: true, length: { maximum: 6 }, inclusion: { in: %w[Gained Burned] }
  validates :register_comment, length: { maximum: 140 }

  def self.comment_search(params)
    where('LOWER(register_comment) LIKE ?', "%#{params.downcase}%")
  end

  def self.min_date_filter(params)
    where('created_at >= ?', params)
  end

  def self.max_date_filter(params)
    date = Date.parse params
    date += 1
    where('created_at <= ?', date)
  end

  def self.days_back(params)
    days_back = Date.today - params.to_i
    where('created_at >= ?', days_back)
  end

  def self.default_days(params)
    days_back = Date.today
    case params
    when 'Day'
      days_back -= 30
      where('created_at >= ?', days_back)
    when 'Week'
      days_back -= 71
      where('created_at >= ?', days_back)
    when 'Month'
      days_back -= 300
      where('created_at >= ?', days_back)
    when 'Year'
      days_back += 1
      where('created_at <= ?', days_back)
    end
  end

  def self.group_chart(params)
    case params
    when 'Day'
      group_by_day(:created_at)
    when 'Week'
      group_by_week(:created_at)
    when 'Month'
      group_by_month(:created_at)
    when 'Year'
      group_by_year(:created_at)
    end
  end
end
