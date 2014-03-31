# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.create({
  first_name: "David",
  last_name: "Miller",
  email: "david@david.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: true
  })

jam1 = Jam.create({
  name: 'Poker',
  description: 'no limit tourney',
  finalized: false,
  user_id: user1.id,
  location: 'my house, 14th and 2nd',
  })

jam_time1 = JamTime.create({
  start_date: '2011-10-12',
  start_time: '15:00:00',
  jam_id: jam1.id
  })

jam_time2 = JamTime.create({
  start_date: '2011-11-11',
  start_time: '13:30:00',
  jam_id: jam1.id
  })

user2 = User.create({
  first_name: "Igor",
  last_name: "Yuzovitzky",
  email: "igor@igor.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: false
  })

jam2 = Jam.create({
  name: 'shopping',
  description: 'shop til we drop, yo!',
  finalized: false,
  user_id: user2.id,
  location: 'the big mall',
  })

user3 = User.create({
  first_name: "Juan",
  last_name: "Johnson",
  email: "juan@juan.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: false
  })

jam3 = Jam.create({
  name: 'coffee',
  description: 'lets get some caffeine',
  finalized: false,
  user_id: user3.id,
  location: 'starbucks!',
  })