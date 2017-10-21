# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

module SocialNetworks
  class Person < ActiveRecord::Base
    has_many :people_social_networks, class_name: 'SocialNetworks::PeopleSocialNetwork', dependent: :destroy
    has_many :social_networks,        class_name: 'SocialNetworks::SocialNetwork', through: :people_social_networks
    has_many :federal_legislators,    class_name: 'Lists::FederalLegislator', dependent: :destroy
    has_many :people_custom_lists,    class_name: 'Lists::PeopleCustomList', dependent: :destroy
    has_many :custom_lists,           class_name: 'Lists::CustomList', through: :people_custom_lists
    has_many :posts,                  class_name: 'SocialNetworks::Post', dependent: :destroy

    validates :first_name, presence: true
    validates :last_name,  presence: true
  end
end
