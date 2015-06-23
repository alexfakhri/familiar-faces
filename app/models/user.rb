class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/panda.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :first_name, :last_name

  has_many :articles

  ROLES = %w[admin contributor]

  subscribe_to "Contributor Email List", :using => { :api_key => ENV['MAILCHIMP_API_KEY'],
                                        :email => :email,
                                        :fields => {:FNAME => :first_name, :LNAME => :last_name}}

end
