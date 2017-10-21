module Lists
  class CustomList < ActiveRecord::Base
    has_many :people_custom_lists, class_name: 'Lists::PeopleCustomList'
    has_many :people,              class_name: 'SocialNetworks::Person', through: :people_custom_lists

    validates :name, presence: true, uniqueness: true
  end
end