class Calorie < ApplicationRecord
  belongs_to :user
  validates :ammount, presence: true, length: { maximum: 4 }
  validates :register_type, presence: true, length: { maximum: 6 }, inclusion: { in: %w[Gained Burned] }
  validates :register_comment, length: { maximum: 140 }

  class << self
    def comment_search(params)
      query = sanitize_sql_like(params.downcase)
      where('LOWER(register_comment) LIKE ?', "%#{query}%")
    end

    def min_date_filter(params)
      where('calories.created_at >= ?', params)
    end

    def max_date_filter(params)
      date = Date.parse params
      date += 1
      where('calories.created_at <= ?', date)
    end

    def days_back(params)
      days_back = Date.today - params.to_i
      where('calories.created_at >= ?', days_back)
    end

    def default_days(params)
      days_back = Date.today
      case params
      when 'Day'
        days_back -= 30
        where('calories.created_at >= ?', days_back)
      when 'Week'
        days_back -= 71
        where('calories.created_at >= ?', days_back)
      when 'Month'
        days_back -= 300
        where('calories.created_at >= ?', days_back)
      when 'Year'
        days_back += 1
        where('calories.created_at <= ?', days_back)
      end
    end

    def group_chart(params)
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
end
