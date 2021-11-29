class User < ApplicationRecord
  attr_accessor :chart_token

  has_many :calorie, dependent: :destroy

  # Callbacks and Conditions
  before_save :downcase_email

  validates :firstname, length: { maximum: 50 }
  validates :lastname, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  class << self
    # Returns the hash digest of the given string.
    def digest(string)
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
 end

  # Returns true if the given token matches the digest.
  def valid_token?(chart_token)
    return false if chart_digest.nil?

    BCrypt::Password.new(chart_digest).is_password?(chart_token)
  end

  # Creates and assigns the chart token.
  def create_chart_token
    self.chart_token = User.new_token
    update_attribute(:chart_digest, User.digest(chart_token))
  end

  def share_chart(friend)
    UserMailer.chart_graph(self, friend).deliver_now
  end

  private

  # Converts email to all lower-case.
  def downcase_email
    email.downcase!
  end
end
