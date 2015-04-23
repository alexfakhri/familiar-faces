class AddStoryToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :story, :text
  end
end
