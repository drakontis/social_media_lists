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
  end
end
