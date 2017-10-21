module SocialNetworks
  class SocialNetwork < ActiveRecord::Base
    has_many :people_social_networks, class_name: 'SocialNetworks::PeopleSocialNetwork'
    has_many :people,                 class_name: 'SocialNetworks::Person', through: :people_social_networks

    validates :name, presence: true, uniqueness: true
  end
end