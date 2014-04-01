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
  email: "davidmiller11@gmail.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: true
  })

jam1 = Jam.create({
  name: 'Pepper spraying cops',
  description: "You know exactly what i'm talking about",
  finalized: false,
  user_id: user1.id,
  location: 'the streets of New York',
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
  first_name: "Larry",
  last_name: "David",
  email: "larry@larry.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: false
  })

jam2 = Jam.create({
  name: 'Stealing candy from babies',
  description: "because it's that easy",
  finalized: false,
  user_id: user2.id,
  location: 'Toys R Us',
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
  name: 'Shopping with the girls',
  description: 'Shop til we drop, yo!',
  finalized: false,
  user_id: user3.id,
  location: 'Dollar Store',
  })

user4 = User.create({
  first_name: "Hugh",
  last_name: "Jaynus",
  email: "hugh@hugh.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: false
  })

user5 = User.create({
  first_name: "Rod",
  last_name: "Rodikoff",
  email: "rod@rod.com",
  password: "pw1",
  password_confirmation: "pw1",
  admin: false
  })