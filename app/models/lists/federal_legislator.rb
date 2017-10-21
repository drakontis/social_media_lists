module Lists
  class FederalLegislator < ActiveRecord::Base
    belongs_to :person, class_name: 'Person'

    validates :person, presence: true
  end
end