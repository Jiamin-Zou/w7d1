# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

CAT_COLORS = %w[black white orange brown].freeze
CAT_SEXES = ["M", "F"]

puts 'Destroying tables ...'
Cat.destroy_all

puts 'Resetting id sequences ...'
ApplicationRecord.connection.reset_pk_sequence!(:cats)

puts 'Loading cats ...'
99.times do
  Cat.create!(
    name: Faker::Creature::Cat.name,
    birth_date: Faker::Date.between(from: '2010-01-01', to: Date.today),
    color: CAT_COLORS.sample,
    sex: CAT_SEXES.sample,
    description: [Faker::Adjective.positive, Faker::Adjective.negative].sample(rand(2..5)).join(", ")
    # description: Faker::Quote.jack_handey
  )
end

puts "Finished loading cats from seed file!"