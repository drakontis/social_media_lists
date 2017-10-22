require 'rails_helper'

describe Forms::Search do
  describe '#search' do
    before do
      facebook = SocialNetworks::SocialNetwork.new(name: 'Facebook')
      facebook.save!
      twitter = SocialNetworks::SocialNetwork.new(name: 'Twitter')
      twitter.save!

      custom_list_1 = Lists::CustomList.new(name: 'CustomList1')
      custom_list_1.save!
      custom_list_2 = Lists::CustomList.new(name: 'CustomList2')
      custom_list_2.save!
      custom_list_3 = Lists::CustomList.new(name: 'CustomList3')
      custom_list_3.save!

      @person1 = SocialNetworks::Person.new(first_name: 'John1',
                                            last_name: 'Doe1',
                                            people_social_networks: [SocialNetworks::PeopleSocialNetwork.new(social_network: facebook,
                                                                                                             person_social_network_id: 'JohnDoe1')],
                                            custom_lists: [custom_list_1, custom_list_2] )
      @person1.save!

      @person2 = SocialNetworks::Person.new(first_name: 'John2',
                                            last_name: 'Doe2',
                                            people_social_networks: [SocialNetworks::PeopleSocialNetwork.new(social_network: twitter,
                                                                                                             person_social_network_id: 'JohnDoe2')],
                                            custom_lists: [custom_list_3] )
      @person2.save!

      @person3 = SocialNetworks::Person.new(first_name: 'John3',
                                            last_name: 'Doe3',
                                            people_social_networks: [SocialNetworks::PeopleSocialNetwork.new(social_network: facebook,
                                                                                                             person_social_network_id: 'JohnDoe3'),
                                                                     SocialNetworks::PeopleSocialNetwork.new(social_network: twitter,
                                                                                                             person_social_network_id: 'JohnDoe3')],
                                            federal_legislator: Lists::DatabaseLists::FederalLegislator.new,
                                            custom_lists: [custom_list_1, custom_list_3] )
      @person3.save!

      @post1 = SocialNetworks::Post.new(body: 'testpost1',
                                        person: @person1,
                                        social_network: facebook,
                                        posted_at: '23/10/2017')
      @post1.save!

      @post2 = SocialNetworks::Post.new(body: 'testpost2',
                                        person: @person2,
                                        social_network: twitter,
                                        posted_at: '24/10/2017')
      @post2.save!

      @post3 = SocialNetworks::Post.new(body: 'testpost3',
                                        person: @person3,
                                        social_network: twitter,
                                        posted_at: '25/10/2017')
      @post3.save!

      @post4 = SocialNetworks::Post.new(body: 'testpost4',
                                        person: @person3,
                                        social_network: facebook,
                                        posted_at: '26/10/2017')
      @post4.save!
    end

    it 'should search without params' do
      search = Forms::Search.new
      result = search.search

      expect(result.count).to eq 4
      expect(result).to include @post1
      expect(result).to include @post2
      expect(result).to include @post3
      expect(result).to include @post4
    end

    it 'should search by lists' do
      search = Forms::Search.new(lists: ['CustomList1', 'CustomList2'])
      result = search.search

      expect(result.count).to eq 3
      expect(result).to include @post1
      expect(result).to include @post3
      expect(result).to include @post4

      expect(result).not_to include @post2
    end

    it 'should search by social networks' do
      search = Forms::Search.new(social_networks: ['Facebook'])
      result = search.search

      expect(result.count).to eq 2
      expect(result).to include @post1
      expect(result).to include @post4

      expect(result).not_to include @post2
      expect(result).not_to include @post3
    end

    it 'should search by multiple social networks' do
      search = Forms::Search.new(social_networks: ['Facebook', 'Twitter'])
      result = search.search

      expect(result.count).to eq 4
      expect(result).to include @post1
      expect(result).to include @post2
      expect(result).to include @post3
      expect(result).to include @post4
    end

    it 'should search by from_date' do
      search = Forms::Search.new(from_date: '25/10/2017')
      result = search.search

      expect(result.count).to eq 2
      expect(result).to include @post3
      expect(result).to include @post4

      expect(result).not_to include @post1
      expect(result).not_to include @post2
    end

    it 'should search by to_date' do
      search = Forms::Search.new(to_date: '24/10/2017')
      result = search.search

      expect(result.count).to eq 2
      expect(result).to include @post1
      expect(result).to include @post2

      expect(result).not_to include @post3
      expect(result).not_to include @post4
    end

    it 'should search by custom list and database list' do
      search = Forms::Search.new(lists: ['CustomList1', 'Federal Legislators'])
      result = search.search

      expect(result.count).to eq 3
      expect(result).to include @post1
      expect(result).to include @post3
      expect(result).to include @post4

      expect(result).not_to include @post2
    end

    it 'should search by custom list, database list, from date, to date and social network' do
      search = Forms::Search.new(lists: ['CustomList1', 'Federal Legislators'],
                                  social_networks: ['Twitter'],
                                  from_date: '25/10/2017',
                                  to_date: '24/10/2017')
      result = search.search

      expect(result.count).to eq 2
      expect(result).to include @post3
      expect(result).to include @post4

      expect(result).not_to include @post1
      expect(result).not_to include @post2
    end
  end

  describe '#applicable_lists' do
    before do
      custom_list_1 = Lists::CustomList.new(name: 'CustomList1')
      custom_list_1.save!
      custom_list_2 = Lists::CustomList.new(name: 'CustomList2')
      custom_list_2.save!
      custom_list_3 = Lists::CustomList.new(name: 'CustomList3')
      custom_list_3.save!
    end

    it 'should return the applicable lists' do
      expect(subject.applicable_lists).to eq ['CustomList1', 'CustomList2', 'CustomList3', 'Federal Legislators']
    end
  end

  describe '#lists' do
    it 'should remove the blank lists' do
      search = Forms::Search.new(lists: ['CustomList1', 'CustomList2', ''])

      expect(search.lists).to eq ['CustomList1', 'CustomList2']
    end
  end

  describe '#social_networks' do
    it 'should remove the blank social_networks' do
      search = Forms::Search.new(social_networks: ['Facebook', 'Twitter', ''])

      expect(search.social_networks).to eq ['Facebook', 'Twitter']
    end
  end

  describe '#lists_from_database' do
    it 'should return the lists_from_database' do
      expect(subject.send(:lists_from_database)).to eq ['Federal Legislators']
    end
  end

  describe '#custom_lists_for_search' do
    it 'should return the lists_from_database' do
      search = Forms::Search.new(lists: ['CustomList1', 'CustomList2', 'Federal Legislators'])

      expect(search.send(:custom_lists_for_search)).to eq ['CustomList1', 'CustomList2']
    end
  end

  describe '#lists_from_database_for_search' do
    it 'should return the lists_from_database_for_search' do
      search = Forms::Search.new(lists: ['CustomList1', 'CustomList2', 'Federal Legislators'])

      expect(search.send(:lists_from_database_for_search)).to eq ['Federal Legislators']
    end
  end
end
