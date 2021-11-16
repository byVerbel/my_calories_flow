module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'Project Two'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def col_datetime
    time = Time.now.getutc
    time -= (60 * 60 * 5)
  end

  def comparison_datetime
    time = col_datetime
    time.strftime('%Y-%m-%d %H:%M:%S UTC')
  end

  def col_date
    time = col_datetime
    time.strftime('%Y-%m-%d')
  end

  def col_time
    time = col_datetime
    time.strftime('%H:%M:%S')
  end
end
