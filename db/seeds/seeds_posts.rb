puts 'Loading Posts...'
number_of_posts = 500000
people = SocialNetworks::Person.all
social_networks = SocialNetworks::SocialNetwork.all

(number_of_posts).times do |index|
  puts "Creating Post ##{index+1}"

  person = people.sample
  body = "#{index} Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
  posted_at = Time.now - rand(1..10000).seconds

  post = SocialNetworks::Post.new(person: person,
                                  body: body,
                                  posted_at: posted_at,
                                  social_network: social_networks.sample)
  post.save!
end

puts '...end of loading Posts...'