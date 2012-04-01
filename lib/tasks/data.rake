require 'faker'

namespace :db do
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    50.times do |n|
      name = Faker::Name.name
      email = "qwerty-#{n}@qwerty.com"
      password = "123456"
      User.create!(:name => name, :email => email, :password => password, :password_confirmation => password);
    end
    User.all(:limit => 10).each do |user|
      15.times do
        user.events.create!(:content => Faker::Lorem.sentence(25), :calendar_date => Date.today.prev_year+rand(730))
      end
      rand(3).times do
        user.events.create!(:content => Faker::Lorem.sentence(10), :calendar_date => Date.today.prev_year+rand(730), :repeat => 4)
      end
      rand(3).times do
        user.events.create!(:content => Faker::Lorem.sentence(10), :calendar_date => Date.today.prev_year+rand(730), :repeat => 3)
      end
      rand(3).times do
        user.events.create!(:content => Faker::Lorem.sentence(10), :calendar_date => Date.today.prev_year+rand(730), :repeat => 2)
      end
      rand(5).times do
        user.events.create!(:content => Faker::Lorem.sentence(10), :calendar_date => Date.today.prev_year+rand(730), :repeat => 1)
      end
    end
  end
end
