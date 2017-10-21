require 'rails_helper'

describe SocialNetwork do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#new' do
    it 'should create a new social network' do
      social_network = SocialNetwork.new(name: 'Facebook')

      social_network.save

      expect(social_network).to be_persisted
      expect(social_network.name).to eq 'Facebook'
    end
  end

  describe '#people' do
    it 'should return the people' do
      person = Person.new(first_name: 'John', last_name: 'Doe')
      person.save

      social_network = SocialNetwork.new(name: 'Facebook')
      social_network.save

      person_social_network = PersonSocialNetwork.new(person: person,
                                                      social_network: social_network,
                                                      person_social_network_id: 'JohnDoe')

      person_social_network.save!

      expect(social_network.people).to include person
    end
  end
end