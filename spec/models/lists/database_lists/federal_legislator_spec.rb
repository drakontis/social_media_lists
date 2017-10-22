# == Schema Information
#
# Table name: federal_legislators
#
#  id         :integer          not null, primary key
#  person_id  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Lists::DatabaseLists::FederalLegislator do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :person }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :person}
  end

  describe '#new' do
    it 'should create a new federal legislator' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)
      federal_legislator.save

      expect(federal_legislator).to be_persisted
      expect(federal_legislator.person).to eq person
    end
  end

  describe '#first_name' do
    it 'should return the first name of the person' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

      expect(federal_legislator.first_name).to eq person.first_name
    end
  end

  describe '#last_name' do
    it 'should return the last name of the person' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

      expect(federal_legislator.last_name).to eq person.last_name
    end
  end

  describe '#facebook_id' do
    context 'with facebook' do
      it 'should return the facebook id' do
        person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
        social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')
        people_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                        social_network: social_network,
                                                                        person_social_network_id: 'JohnDoe')
        people_social_network.save!
        federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

        expect(federal_legislator.facebook_id).to eq people_social_network.person_social_network_id
      end
    end

    context 'without facebook' do
      it 'should return nil' do
        person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
        federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

        expect(federal_legislator.facebook_id).to be_nil
      end
    end
  end

  describe '#twitter_username' do
    context 'with twitter' do
      it 'should return the twitter name' do
        person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
        social_network = SocialNetworks::SocialNetwork.new(name: 'Twitter')
        people_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                        social_network: social_network,
                                                                        person_social_network_id: 'JohnDoe')
        people_social_network.save!
        federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

        expect(federal_legislator.twitter_username).to eq people_social_network.person_social_network_id
      end
    end

    context 'without twitter' do
      it 'should return nil' do
        person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
        federal_legislator = Lists::DatabaseLists::FederalLegislator.new(person: person)

        expect(federal_legislator.twitter_username).to be_nil
      end
    end
  end
end
