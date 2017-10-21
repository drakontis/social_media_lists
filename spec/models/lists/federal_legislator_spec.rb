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

describe Lists::FederalLegislator do
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

      federal_legislator = Lists::FederalLegislator.new(person: person)
      federal_legislator.save

      expect(federal_legislator).to be_persisted
      expect(federal_legislator.person).to eq person
    end
  end
end
