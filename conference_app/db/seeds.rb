# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Database..."

Talk.delete_all

talks_data = []

10.times do
  talks_data << {
    topic: FFaker::Company.catch_phrase,
    duration: [20,30,40,60].sample
  }
end

talks = Talk.create(talks_data)
# puts talks.map {|t| "#{t.id}, #{t.topic}"}

puts "Seeded #{talks.count} talks"
