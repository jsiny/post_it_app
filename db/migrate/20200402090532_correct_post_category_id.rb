class CorrectPostCategoryId < ActiveRecord::Migration[6.0]
  def change
    add_column :post_categories, :category_id, :integer 
  end
end
