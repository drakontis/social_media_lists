# == Schema Information
#
# Table name: custom_lists
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

module Lists
  class CustomList < ActiveRecord::Base
    has_many :people_custom_lists, class_name: 'Lists::PeopleCustomList', dependent: :destroy
    has_many :people,              class_name: 'SocialNetworks::Person', through: :people_custom_lists

    validates :name, presence: true, uniqueness: true
  end
end
