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

require 'rails_helper'

describe SocialNetworks::Post do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :person    }
    it { is_expected.to validate_presence_of :body      }
    it { is_expected.to validate_presence_of :posted_at }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :person         }
    it { is_expected.to belong_to :social_network }
  end

  describe '#new' do
    it 'should create a new post' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')

      posted_time = Time.now
      post = SocialNetworks::Post.new(person: person,
                                      posted_at: posted_time,
                                      body: 'Lorem Ipsum',
                                      social_network: social_network)

      expect do
        post.save
      end.to change{ SocialNetworks::Post.count }.by 1

      expect(post).to be_persisted
      expect(post.person).to eq person
      expect(post.posted_at).to eq posted_time
      expect(post.body).to eq 'Lorem Ipsum'
      expect(post.social_network).to eq social_network
    end
  end
end
