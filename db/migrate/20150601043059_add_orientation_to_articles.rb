class AddOrientationToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :image_orientation, :string
  end
end
