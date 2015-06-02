class AddVisibilityToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :visibility, :boolean, default: false
  end
end
