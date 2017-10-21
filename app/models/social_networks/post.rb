module SocialNetworks
  class Post < ActiveRecord::Base
    belongs_to :person, class_name: 'SocialNetworks::Person'

    validates :person,    presence: true
    validates :body,      presence: true
    validates :posted_at, presence: true
  end
end