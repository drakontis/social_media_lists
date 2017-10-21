require 'rails_helper'

describe Lists::PeopleCustomList do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :person      }
    it { is_expected.to validate_presence_of :custom_list }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :person      }
    it { is_expected.to belong_to :custom_list }
  end

  describe '#new' do
    it 'should create a new people custom list' do
      custom_list = Lists::CustomList.new(name: 'state governors')
      custom_list.save!

      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save!

      people_custom_list = Lists::PeopleCustomList.new(custom_list: custom_list,
                                                       person: person)

      expect do
        people_custom_list.save
      end.to change{ Lists::PeopleCustomList.count }.by 1

      expect(people_custom_list).to be_persisted
      expect(people_custom_list.custom_list).to eq custom_list
      expect(people_custom_list.person).to eq person
    end
  end
end