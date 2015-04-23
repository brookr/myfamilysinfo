# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
# puts 'DEFAULT USERS'
# user = User.find_or_create_by_email :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
# puts 'user: ' << user.email
require 'ffaker'


15.times do
  User.new.tap do |u|
    u.email = FFaker::Internet.email
    u.password = 'password'
    u.save!
  end
end

45.times do
  Kid.new.tap do |k|
    k.name = FFaker::Name.first_name
    k.save!
  end
end

kid = Kid.all.each do |k|
  user = User.order( 'RANDOM()' ).first
  user.kids << k
end

Kid.all.each do |k|
  rand(4).times do
    r = k.reminders.create
    r.type = ["Medicine", "Temperature", "HeightWeight", "Symptom"][(rand * 4).to_i]
    case r.type
    when "Medicine"
      r.meds = FFaker::Product.product_name
    when "Temperature"
      r.temperature = (rand*10) + 95
    when "HeightWeight"
      if [true, false][(rand*2).to_i]
        r.height = "#{((rand*2).to_i + 4)}'#{((rand*12).to_i)}\""
      else
        r.weight = (rand*100).to_i + 8
      end
    when "Symptom"
      description = FFaker::Product.product_name
    end
    r.save!
  end
end
