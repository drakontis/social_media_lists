# == Schema Information
#
# Table name: social_networks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe SocialNetworks::SocialNetwork do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'Associations' do
    it { is_expected.to have_many :people_social_networks }
    it { is_expected.to have_many :people                 }
    it { is_expected.to have_many :posts                  }
  end

  describe '#new' do
    it 'should create a new social network' do
      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')

      social_network.save

      expect(social_network).to be_persisted
      expect(social_network.name).to eq 'Facebook'
    end
  end

  describe '#people' do
    it 'should return the people' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')
      social_network.save

      person_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                      social_network: social_network,
                                                                      person_social_network_id: 'JohnDoe')

      person_social_network.save!

      expect(social_network.people).to include person
    end
  end
end
