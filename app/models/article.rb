class Article < ActiveRecord::Base

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  has_attached_file :photo, :styles => { :homepage => "300x500>", :portrait => "585>", :landscape => "500x300>" }, :default_url => "/images/:style/panda.jpg", :s3_protocol => :https
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  validates :title, length: {minimum: 4}
  validates :location, :photo, presence: true

  belongs_to :user

  acts_as_taggable

  geocoded_by :location
  after_validation :geocode

  IMAGE_ORIENTATION = %w[portrait landscape]


end
