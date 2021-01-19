class Post < ApplicationRecord
  belongs_to :user

  # TODO: Copy-paste your code from previous exercise
  validates :url, :user, presence: true
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :url, uniqueness: true
  validates :title, length: { minimum: 5 }
  validates :url, format: { with: /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$\z/ }
  # SCOPES:
  scope :by_most_popular, -> { order(votes: :desc) }
  # end
end
