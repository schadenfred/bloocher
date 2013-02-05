require 'rubygems'
require 'faker'

Dir[Rails.root.join("lib/sample_data/*.rb")].each {|f| require f}

include WineData
include ReviewData
include MiscellaneousData
 
def colorize(text, color_code)
 "\e[#{color_code}m#{text}\e[0m"
end

def red(text);      colorize(text, 31); end
def green(text);    colorize(text, 32); end
def yellow(text);   colorize(text, 33); end
def purple(text);   colorize(text, 34); end
def magenta(text);  colorize(text, 35); end
def cyan(text);     colorize(text, 36); end

namespace :db do
  desc "Fill database with sample data" 
  task populate: :environment do
    # if Rails.env.development?
      puts "#{red("==>")} Clearing Current Data"
      Rake::Task['db:reset'].invoke
    # end
    puts "#{green("==>")} Making admin user"
    make_admin_user
    puts "#{green("==>")} Making sample users"
    make_users
    puts "#{green("==>")} Making wineries"
    make_wineries    
    puts "#{green("==>")} Making wines"
    make_wines
    puts "#{green("==>")} Making reviews"
    make_reviews
    puts "#{green("==>")} Making producers"
    make_producers  
    puts "#{green("==>")} Making ownerships"
    make_ownerships
    puts "#{green("==>")} Making winemaker oeuvres"
    make_winemaker_oeuvres
    puts "#{green("==>")} Making vineyards"
    make_vineyards
    
  end
end

def make_admin_user

  admin_user = User.new(
    name: "Fred Schoeneman", 
    email: "fred.schoeneman@gmail.com", 
    password: "password",
    password_confirmation: "password", 
    bio: hipster_bio)
  admin_user.skip_confirmation!
  admin_user.save!
  admin_user.confirm!
end

def make_users

  99.times do |n|
    name = Faker::Name.name 
    email = Faker::Internet.email
    password  = "password"
    user = User.new(name: name,
                    :email => email,
                    :password => password,
                    bio: Faker::Company.bs)  
    user.skip_confirmation!
    user.save!
    user.confirm!
  end
end

def make_wineries

  boonville_wineries.each do |winery_name|
    Winery.create(
      name: winery_name, 
      producer_id: rand(1..20)
    )
  end
end

def make_wines
  
  99.times do |n|
    vintage = rand(2002..2011)
    bottled_on_year = vintage + 1
    released_on_year = vintage + rand(1..2)
    lay_down_until_year = vintage + rand(1..4)
    drink_before_year = vintage + rand(10..20)
    new_french_oak = (rand(0..100).to_f)/100
    Wine.create!( 
      vintage: vintage,
      cases_produced: rand(2000..100000),
      name: "#{wine_types.sample} \- #{vineyard_names.sample} \- #{differentiators.sample}",
      winery_id: rand(1..28),   
      acid_added: rand(0..1),
      new_french_oak: rand(1..100),
      days_in_oak: rand(90..180),
      bottled_on: "#{bottled_on_year}-#{rand(1..12)}-#{rand(1..30)}",
      released_on: "#{released_on_year}-#{rand(1..12)}-#{rand(1..30)}",
      
      winemaker_notes: Faker::Lorem.paragraphs(5),
      ph: "#{(rand(665..755).to_f)/100}",
      residual_sugar: "#{(rand(1..5).to_f)/100}",
      alcohol: "#{(rand(125..175).to_f)/1000}",
      new_french_oak: new_french_oak,
      one_yr_old_french_oak: "#{(100 - new_french_oak)/7}",
      two_yr_old_french_oak: "#{(100 - new_french_oak)/7}",
      three_yr_old_french_oak: "#{(100 - new_french_oak)/7}",
      new_american_oak: "#{(100 - new_french_oak)/7}",
      one_yr_old_american_oak: "#{(100 - new_french_oak)/7}",
      two_yr_old_american_oak: "#{(100 - new_french_oak)/7}",
      three_yr_old_american_oak: "#{(100 - new_french_oak)/7}"
    )
  end
end

def make_reviews 
  99.times do |n|
    Review.create(
      rating: rand(70..95),
      reviewer_id: rand(1..99),
      wine_id: rand(1..99),
      # content: Faker::Lorem.paragraphs
      content: hipster_review
    )
  end
end

def make_producers
  20.times do |n|
    name = boonville_producers.sample
    subdomain = name.gsub(" ", "-")
    web_address = "http://www." + subdomain + "." + Faker::Internet.domain_suffix
    Producer.create(
      address_1: Faker::Address.street_address,
      address_2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip_code,
      name: name,
      subdomain: subdomain,
      web_address: web_address
    )
  end
end

def make_ownerships

  users = User.all
  users.each do |owner|
    Ownership.create(owner_id: owner.id, 
      producer_id: rand(1..20)
    )
  end
end

def make_winemaker_oeuvres
  99.times do |n|
    WinemakerOeuvre.create(
      wine_id: rand(1..10),
      winemaker_id: rand(1..20)
    )
  end

end

def make_vineyards

  boonville_vineyards.each do |vineyard_name|
    Vineyard.create(
      name: vineyard_name, 
      producer_id: rand(1..20),
      appellation: appellations.sample,
      topo_aspect: topo_aspects.sample,
      topo_slope: rand(1..50)/1000.to_f,
      topo_elevation: rand(10..8000),
      soil_composition: soil_types.sample,
      soil_drainage: soil_drainage_types.sample,
      soil_depth: rand(18..40),
      soil_fertility: rand(1..40)/1000.to_f,
      soil_water_capacity: rand(6..8),
      soil_ph: rand(38..80)/10.to_f,
    )
  end

end

