# == Schema Information
#
# Table name: people_custom_lists
#
#  id             :integer          not null, primary key
#  person_id      :integer          not null
#  custom_list_id :integer          not null
#  created_at     :datetime
#  updated_at     :datetime
#

module Lists
  class PeopleCustomList < ActiveRecord::Base
    belongs_to :person,      class_name: 'SocialNetworks::Person'
    belongs_to :custom_list, class_name: 'Lists::CustomList'

    validates :person,      presence: true
    validates :custom_list, presence: true

    validates :custom_list, uniqueness: { scope: :person, case_sensitive: false }
  end
end
