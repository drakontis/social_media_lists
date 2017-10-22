puts 'Loading Custom Lists...'

100.times do |index|
  Lists::CustomList.find_or_create_by(name: "CustomList#{index+1}")
end

puts '...end of loading Custom Lists...'