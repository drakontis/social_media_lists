puts 'Loading People...'

number_of_people = 5000

custom_lists = Lists::CustomList.all
social_networks = SocialNetworks::SocialNetwork.all

number_of_people.times do |index|
  puts "Creating person ##{index+1}"

  person = SocialNetworks::Person.new(first_name: "John#{index+1}", last_name: "Doe#{index+1}")

  if index.odd?
    social_network = social_networks.sample
    people_social_network = SocialNetworks::PeopleSocialNetwork.new(social_network: social_network,
                                                                    person_social_network_id: "John#{index+1}.Doe#{index+1}")
  else
    social_networks.each do |social_network|
      people_social_network = SocialNetworks::PeopleSocialNetwork.new(social_network: social_network,
                                                                      person_social_network_id: "John#{index+1}.Doe#{index+1}")
    end
  end
  person.people_social_networks << people_social_network

  number_of_custom_lists = rand(1..custom_lists.count/20)

  custom_lists.sample(number_of_custom_lists).each do |custom_list|
    person.custom_lists << custom_list
  end

  if rand(1..1000) == 1000
    person.federal_legislators = Lists::FederalLegislator.new
  end

  person.save!
end

puts '...end of loading People.'