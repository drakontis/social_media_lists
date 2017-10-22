# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  body       :text             not null
#  posted_at  :datetime         not null
#  created_at :datetime
#  updated_at :datetime
#

module SocialNetworks
  class Post < ActiveRecord::Base
    belongs_to :person,         class_name: 'SocialNetworks::Person'
    belongs_to :social_network, class_name: 'SocialNetworks::SocialNetwork'

    validates :person,    presence: true
    validates :body,      presence: true
    validates :posted_at, presence: true
  end
end
