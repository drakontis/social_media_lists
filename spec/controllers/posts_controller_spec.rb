require 'rails_helper'

describe PostsController, :type => :controller do
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
    get :index

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 4
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post2
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4
  end

  it 'should search by lists' do
    get :index, {forms_search: {lists: ['CustomList1', 'CustomList2']}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 3
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4

    expect(assigned_posts).not_to include @post2
  end

  it 'should search by social networks' do
    get :index, {forms_search: {social_networks: ['Facebook']}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 2
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post4

    expect(assigned_posts).not_to include @post2
    expect(assigned_posts).not_to include @post3
  end

  it 'should search by multiple social networks' do
    get :index, {forms_search: {social_networks: ['Facebook', 'Twitter']}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 4
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post2
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4
  end

  it 'should search by from_date' do
    get :index, {forms_search: {from_date: '25/10/2017'}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 2
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4

    expect(assigned_posts).not_to include @post1
    expect(assigned_posts).not_to include @post2
  end

  it 'should search by to_date' do
    get :index, {forms_search: {to_date: '24/10/2017'}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 2
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post2

    expect(assigned_posts).not_to include @post3
    expect(assigned_posts).not_to include @post4
  end

  it 'should search by custom list and database list' do
    get :index, {forms_search: {lists: ['CustomList1', 'Federal Legislators']}}

    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    assigned_posts = assigns(:posts)

    expect(assigned_posts.count).to eq 3
    expect(assigned_posts).to include @post1
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4

    expect(assigned_posts).not_to include @post2
  end

  it 'should search by custom list, database list, from date, to date and social network' do
    get :index, {forms_search: {lists: ['CustomList1', 'Federal Legislators'],
                                social_networks: ['Twitter'],
                                from_date: '25/10/2017',
                                to_date: '24/10/2017'}}

    assigned_posts = assigns(:posts)
    expect(response.status).to eq 200
    expect(response).to render_template 'index'

    expect(assigned_posts.count).to eq 2
    expect(assigned_posts).to include @post3
    expect(assigned_posts).to include @post4

    expect(assigned_posts).not_to include @post1
    expect(assigned_posts).not_to include @post2
  end
end