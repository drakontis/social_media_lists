module Forms
  class Search
    include ActiveModel::Model

    attr_accessor :lists,
                  :from_date,
                  :to_date,
                  :social_networks

    def search
      posts = SocialNetworks::Post
      posts = posts.joins(:person => :custom_lists).where("custom_lists.name IN (?)", custom_lists_for_search) unless custom_lists_for_search.blank?
      posts = posts.where("posted_at >= ?", from_date.to_date.beginning_of_day) if from_date.present?
      posts = posts.where("posted_at <= ?", to_date.to_date.beginning_of_day) if to_date.present?

      posts = posts.joins(:social_network).where("social_networks.name IN (?)", social_networks) unless social_networks.blank?

      lists_from_database_for_search.each do |list|
        database_list = list.downcase.gsub(' ', '_')
        posts += SocialNetworks::Post.joins(:person => database_list.singularize.to_sym).where("#{database_list}.person_id = people.id")
      end

      posts.uniq
    end

    def applicable_lists
      Lists::CustomList.all.map(&:name) + lists_from_database
    end

    def lists
      @lists.reject(&:empty?) if @lists.present?
    end

    def social_networks
      @social_networks.reject(&:empty?) if @social_networks.present?
    end

    #######
    private
    #######

    def custom_lists_for_search
      lists.blank? ? [] : lists - lists_from_database
    end

    def lists_from_database_for_search
      lists.blank? ? [] : lists & lists_from_database
    end

    def lists_from_database
      ['Federal Legislators']
    end

  end
end