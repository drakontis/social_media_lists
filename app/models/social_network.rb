class SocialNetwork < ActiveRecord::Base
  has_many :person_social_networks, class_name: 'PersonSocialNetwork'
  has_many :people,                 class_name: 'Person', through: :person_social_networks

  validates :name, presence: true, uniqueness: true
end