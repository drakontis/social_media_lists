class Person < ActiveRecord::Base
  has_many :person_social_networks, class_name: 'PersonSocialNetwork'
  has_many :social_networks,        class_name: 'SocialNetwork', through: :person_social_networks
  has_many :federal_legislators,    class_name: 'Lists::FederalLegislator'
  has_many :people_custom_lists,    class_name: 'Lists::PeopleCustomList'
  has_many :custom_lists,           class_name: 'Lists::CustomList', through: :people_custom_lists

  validates :first_name, presence: true
  validates :last_name,  presence: true
end