class PeopleSocialNetwork < ActiveRecord::Base
  belongs_to :person,         class_name: 'Person'
  belongs_to :social_network, class_name: 'SocialNetwork'

  validates :person,                   presence: true
  validates :social_network,           presence: true
  validates :person_social_network_id, presence: true
  validates :social_network,           uniqueness: { scope: :person, case_sensitive: false }
end