# == Schema Information
#
# Table name: people
#
#  id         :integer          not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe SocialNetworks::Person do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name  }
  end

  describe 'Associations' do
    it { is_expected.to have_many :people_social_networks }
    it { is_expected.to have_many :social_networks        }
    it { is_expected.to have_one  :federal_legislators    }
    it { is_expected.to have_many :people_custom_lists    }
    it { is_expected.to have_many :custom_lists           }
    it { is_expected.to have_many :posts                  }
  end

  describe '#new' do
    it 'should create a new person' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')

      person.save

      expect(person).to be_persisted
      expect(person.first_name).to eq 'John'
      expect(person.last_name).to eq 'Doe'
    end
  end

  describe '#social_networks' do
    it 'should return the social networks' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')
      social_network.save

      people_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                      social_network: social_network,
                                                                      person_social_network_id: 'JohnDoe')

      people_social_network.save!

      expect(person.social_networks).to include social_network
    end
  end

  describe '#custom_lists' do
    it 'should return the custom lists' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save!

      custom_list = Lists::CustomList.new(name: 'state governor')
      custom_list.save!

      people_custom_list = Lists::PeopleCustomList.new(person: person, custom_list: custom_list)
      people_custom_list.save

      expect(person.people_custom_lists).to include people_custom_list
      expect(person.custom_lists).to include custom_list
    end
  end

  describe '#social_network' do
    it 'should return the people_social_network' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')
      social_network.save

      people_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                      social_network: social_network,
                                                                      person_social_network_id: 'JohnDoe')

      people_social_network.save!

      expect(person.social_network('Facebook')).to eq people_social_network
    end
  end

  describe '#name' do
    it 'should return the full name' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')

      expect(person.name).to eq 'John Doe'
    end
  end
end