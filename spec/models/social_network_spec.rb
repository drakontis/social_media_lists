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
end