# == Schema Information
#
# Table name: federal_legislators
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

module Lists
  class FederalLegislator < ActiveRecord::Base
    belongs_to :person, class_name: 'SocialNetworks::Person'

    validates :person, presence: true

    def first_name
      person.first_name
    end

    def last_name
      person.last_name
    end

    def facebook_id
      person.social_network('Facebook').try(:person_social_network_id)
    end

    def twitter_username
      person.social_network('Twitter').try(:person_social_network_id)
    end
  end
end
