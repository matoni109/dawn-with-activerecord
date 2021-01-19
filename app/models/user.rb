class User < ApplicationRecord
  has_many :posts, dependent: :destroy #

  # TODO: Copy-paste your code from previous exercise
  before_validation :ensure_email_is_stripped

  # TODO: Add some validation
  validates :username, :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # TODO: Add some callbacks
  # after_create :send_welcome_email

  private
  def ensure_email_is_stripped
    self.email.strip! unless email.nil?
  end

  # def send_welcome_email
  #   FakeMailer.instance.mail(self.email, "Welcome Email")
  # end
end
