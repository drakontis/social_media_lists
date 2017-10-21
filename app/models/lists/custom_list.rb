module Lists
  class CustomList < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
  end
end