# == Schema Information
#
# Table name: people_social_networks
#
#  id                       :integer          not null, primary key
#  person_id                :integer          not null
#  social_network_id        :integer          not null
#  person_social_network_id :string           not null
#  created_at               :datetime
#  updated_at               :datetime
#

module SocialNetworks
  class PeopleSocialNetwork < ActiveRecord::Base
    belongs_to :person,         class_name: 'SocialNetworks::Person'
    belongs_to :social_network, class_name: 'SocialNetworks::SocialNetwork'

    validates :person,                   presence: true
    validates :social_network,           presence: true
    validates :person_social_network_id, presence: true
    validates :social_network,           uniqueness: { scope: :person, case_sensitive: false }
  end
end
