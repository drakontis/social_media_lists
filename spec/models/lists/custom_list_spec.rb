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
end