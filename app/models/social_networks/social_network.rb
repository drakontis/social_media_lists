# == Schema Information
#
# Table name: social_networks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

module SocialNetworks
  class SocialNetwork < ActiveRecord::Base
    has_many :people_social_networks, class_name: 'SocialNetworks::PeopleSocialNetwork', dependent: :destroy
    has_many :people,                 class_name: 'SocialNetworks::Person', through: :people_social_networks

    validates :name, presence: true, uniqueness: true
  end
end
