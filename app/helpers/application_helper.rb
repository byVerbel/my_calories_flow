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

  # Gravatar
  def gravatar_for(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user_full_name(user), class: 'gravatar')
  end

  # User functions
  def user_full_name(user)
    user.firstname + ' ' + user.lastname
  end

  # Time functions to convert to col
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
