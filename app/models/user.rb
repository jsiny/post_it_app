class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  before_save :generate_slug

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  def generate_slug
    self.slug = self.username.parameterize
  end
end