module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug!
    class_attribute :slug_column
  end

  def generate_slug!
    temp_slug = self.send(self.class.slug_column).parameterize
    count = 2

    loop do
      object = self.class.find_by slug: temp_slug
      break unless object && object != self

      temp_slug = append_suffix(temp_slug, count)
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

  class_methods do
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end