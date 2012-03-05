Factory.define :user do |user|
  user.name 'Rashid'
  user.email 'some@email.org'
  user.password '654321'
  user.password_confirmation '654321'
end

Factory.define :event do |event|
  event.content "some events"
  event.calendar_date Date.new(1996,3,4)
  event.association :user
end

Factory.sequence :email do |n|
  "some#{n}@mail.org"
end
