class Category < ActiveRecord::Base
  include ModelHelper

  has_many :post_categories
  has_many :posts, through: :post_categories

  before_save :generate_slug

  validates :name, presence: true

  def generate_slug
    temp_slug = self.name.parameterize
    count = 2

    loop do
      cat = Category.find_by slug: temp_slug
      break unless cat && cat != self

      temp_slug = append_suffix(temp_slug, count)
      count += 1
    end

    self.slug = temp_slug
  end

  def to_param
    self.slug
  end
end