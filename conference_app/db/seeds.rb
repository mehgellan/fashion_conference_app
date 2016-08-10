p "Hello from seed.rb"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'
10.times do
first = FFaker::Name.first_name
last = FFaker::Name.last_name
email = FFaker::Internet.email
new_speaker = {:first=>first, :last=>last, :email=>email}
end
# speakers_data = [
#   {:first=>"Bill", :last=>"Fauver", :email=>"cory@example.com"},
#   {:first=>"Billan", :last=>"Lopker", :email=>"juliana@example.com"},
#   {:first=>"Bill", :last=>"Cauthen", :email=>"will@example.com"},
#   {:first=>"Bill", :last=>"Brennan", :email=>"nick@example.com"}
# ]
# Speaker.create(speakers_data)
p "deleted all #{Speaker.delete_all}"
Speaker.create(new_speaker)
p "created new  speaker #{Speaker.last}"
