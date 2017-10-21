require 'rails_helper'

describe Lists::CustomList do
  describe 'Validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe '#new' do
    it 'should create a new custom list' do
      custom_list = Lists::CustomList.new(name: 'state governors')
      custom_list.save

      expect(custom_list).to be_persisted
      expect(custom_list.name).to eq 'state governors'
    end
  end

  describe '#people' do
    it 'should return the people' do
      person = SocialNetworks::Person.new(first_name: 'John', last_name: 'Doe')
      person.save!

      custom_list = Lists::CustomList.new(name: 'state governor')
      custom_list.save!

      people_custom_list = Lists::PeopleCustomList.new(person: person, custom_list: custom_list)
      people_custom_list.save

      expect(custom_list.people_custom_lists).to include people_custom_list
      expect(custom_list.people).to include person
    end
  end
end