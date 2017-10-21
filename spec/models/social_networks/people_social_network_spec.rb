require 'rails_helper'

describe SocialNetworks::PeopleSocialNetwork do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :person                   }
    it { is_expected.to validate_presence_of :social_network           }
    it { is_expected.to validate_presence_of :person_social_network_id }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :person         }
    it { is_expected.to belong_to :social_network }
  end

  describe '#new' do
    it 'should create a new person_social_network' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      social_network = SocialNetworks::SocialNetwork.new(name: 'Facebook')
      person_social_network = SocialNetworks::PeopleSocialNetwork.new(person: person,
                                                                      social_network: social_network,
                                                                      person_social_network_id: 'JohnDoe')

      expect do
        expect do
          person_social_network.save
        end.to change{ SocialNetworks::PeopleSocialNetwork.count }.by 1
      end.to change{ SocialNetworks::Person.count }.by 1

      person = SocialNetworks::Person.last
      expect(person.first_name).to eq 'John'
      expect(person.last_name).to eq 'Doe'

      person_social_network = SocialNetworks::PeopleSocialNetwork.last
      expect(person_social_network.person).to eq person
      expect(person_social_network.social_network).to eq social_network
      expect(person_social_network.person_social_network_id).to eq 'JohnDoe'
    end
  end
end