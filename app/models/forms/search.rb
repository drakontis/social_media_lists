module Forms
  class Search
    include ActiveModel::Model

    attr_accessor :lists,
                  :from_date,
                  :to_date,
                  :social_networks

    def search

    end

    def applicable_lists
      Lists::CustomList.all.map(&:name) + lists_from_database
    end

    #######
    private
    #######

    def lists_from_database
      ['Federal Legislators']
    end

  end
end