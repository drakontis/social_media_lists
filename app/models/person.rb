class Person < ActiveRecord::Base
  has_many :person_social_networks, class_name: 'PersonSocialNetwork'
  has_many :social_networks,        class_name: 'SocialNetwork', through: :person_social_networks

  validates :first_name, presence: true
  validates :last_name,  presence: true
end