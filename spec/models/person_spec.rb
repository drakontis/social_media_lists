require 'rails_helper'

describe Person do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name  }
  end

  describe 'Associations' do
    it { is_expected.to have_many :person_social_networks }
    it { is_expected.to have_many :social_networks        }
    it { is_expected.to have_many :federal_legislators    }
    it { is_expected.to have_many :people_custom_lists    }
    it { is_expected.to have_many :custom_lists           }
  end

  describe '#new' do
    it 'should create a new person' do
      person = Person.new(first_name: 'John', last_name: 'Doe')

      person.save

      expect(person).to be_persisted
      expect(person.first_name).to eq 'John'
      expect(person.last_name).to eq 'Doe'
    end
  end

  describe '#social_networks' do
    it 'should return the social networks' do
      person = Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetwork.new(name: 'Facebook')
      social_network.save

      person_social_network = PersonSocialNetwork.new(person: person,
                                                      social_network: social_network,
                                                      person_social_network_id: 'JohnDoe')

      person_social_network.save!

      expect(person.social_networks).to include social_network
    end
  end

  describe '#custom_lists' do
    it 'should return the custom lists' do
      person = Person.new(first_name: 'John', last_name: 'Doe')
      person.save!

      custom_list = Lists::CustomList.new(name: 'state governor')
      custom_list.save!

      people_custom_list = Lists::PeopleCustomList.new(person: person, custom_list: custom_list)
      people_custom_list.save

      expect(person.people_custom_lists).to include people_custom_list
      expect(person.custom_lists).to include custom_list
    end
  end
end