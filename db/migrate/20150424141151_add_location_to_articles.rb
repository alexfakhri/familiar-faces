class AddLocationToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :location, :text
  end
end
