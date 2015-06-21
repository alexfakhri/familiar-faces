class Article < ActiveRecord::Base

  has_attached_file :photo, :styles => { :homepage => "300x500>", :portrait => "585>", :landscape => "500x300>" }, :default_url => "/images/:style/panda.jpg"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  acts_as_taggable

  IMAGE_ORIENTATION = %w[portrait landscape]

end
