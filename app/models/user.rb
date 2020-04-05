class User < ActiveRecord::Base
  include ModelHelper

  has_many :posts
  has_many :comments
  has_many :votes

  before_save :generate_slug

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 5 }

  def generate_slug
    temp_slug = self.username.parameterize
    count = 2

    loop do
      user = User.find_by slug: temp_slug
      break unless user && user != self

      temp_slug = append_suffix(temp_slug, count)
      count += 1
    end

    self.slug = temp_slug
  end

  def to_param
    self.slug
  end
end