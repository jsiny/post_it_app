class Post < ActiveRecord::Base
  include ModelHelper

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :url, uniqueness: true

  def generate_slug
    temp_slug = self.title.parameterize
    count = 2

    loop do
      post = Post.find_by slug: temp_slug
      break unless post && post != self

      temp_slug = append_suffix(temp_slug, count)
      count += 1
    end

    self.slug = temp_slug
  end

  def to_param
    self.slug
  end

  private

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size
  end
end