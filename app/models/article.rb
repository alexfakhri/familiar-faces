class Article < ActiveRecord::Base

  has_attached_file :photo, :styles => { :portrait => "300x500>", :landscape => "500x300>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  acts_as_taggable

end
