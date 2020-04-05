class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :votes, as: :voteable

  before_save :generate_slug

  validates :title, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :url, uniqueness: true

  def total_votes
    up_votes - down_votes
  end

  def generate_slug
    temp_slug = self.title.parameterize
    post = Post.find_by slug: temp_slug
    count = 2

    while post && post != self
      temp_slug = append_suffix(temp_slug, count)
      post = Post.find_by slug: temp_slug
      count += 1
    end

    self.slug = temp_slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-#{count}"
    end
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