module Forms
  class Search
    include ActiveModel::Model

    attr_accessor :lists,
                  :from_date,
                  :to_date,
                  :social_networks

    def search
      posts = SocialNetworks::Post.where(nil)
      posts = posts.where("posted_at >= ?", from_date.to_date.beginning_of_day) if from_date.present?
      posts = posts.where("posted_at <= ?", to_date.to_date.beginning_of_day) if to_date.present?
      posts = posts.joins(:social_network).where("social_networks.name IN (?)", social_networks) unless social_networks.blank?

      ##
      # Start of searching by lists.
      # In the following fragment of code, we create the query that filters the posts of people that belong in specified lists.
      # First it searches for people that belong to custom lists only if custom_lists_for_search is not blank
      # and after that it searches for people that are included in database_lists only if the lists_from_database_for_search is not blank.
      # Both queries should be applied in the *posts* ActiveRecord::Relation variable, that's why posts_tmp variable exists.
      #
      # Finally we should combine the results of the two queries.
      # If the custom_lists_for_search is not blank, we just assign the query to the posts variable,
      # otherwise we need to merge the two queries in order to fetch the posts for both list types.
      #
      posts_tmp = posts

      unless custom_lists_for_search.blank?
        posts = posts.joins(:person => :custom_lists).where("custom_lists.name IN (?)", custom_lists_for_search) unless custom_lists_for_search.blank?
      end

      unless lists_from_database_for_search.blank?
        lists_from_database_for_search.each do |list|
          database_list = list.downcase.gsub(' ', '_')

          if custom_lists_for_search.blank?
            posts = posts_tmp.joins(:person => database_list.singularize.to_sym).where("#{database_list}.person_id = people.id")
          else
            posts += posts_tmp.joins(:person => database_list.singularize.to_sym).where("#{database_list}.person_id = people.id")
          end
        end
      end
      # End of searching by lists

      posts.uniq

      #
      # The following line used to return an ActiveRecord::Relation instead of Array
      # The ActiveRecord::Relation is needed by the kaminari gem.
      SocialNetworks::Post.where('id in (?)', posts.map(&:id))
    end

    ##
    # We use this method in select input in the search form in order to fill the applicable lists for search
    #
    def applicable_lists
      Lists::CustomList.all.map(&:name) + lists_from_database
    end

    ##
    # override the lists getter in order to reject any empty string element
    #
    def lists
      @lists.reject(&:empty?) if @lists.present?
    end

    ##
    # override the social_networks getter in order to reject any empty string element
    #
    def social_networks
      @social_networks.reject(&:empty?) if @social_networks.present?
    end

    #######
    private
    #######

    ##
    # Return the custom lists that are selected in the search form
    #
    def custom_lists_for_search
      lists.blank? ? [] : lists - lists_from_database
    end

    ##
    # Return only the database_lists that are selected in the search form
    #
    def lists_from_database_for_search
      lists.blank? ? [] : lists & lists_from_database
    end

    ##
    # This method return the lists that are generated from the database
    #
    def lists_from_database
      ['Federal Legislators']
    end

  end
end