puts 'Loading Social Networks...'

SocialNetworks::SocialNetwork.find_or_create_by(name: 'Facebook')
SocialNetworks::SocialNetwork.find_or_create_by(name: 'Twitter')

puts '...end of loading Social Networks.'