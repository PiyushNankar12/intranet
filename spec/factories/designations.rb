FactoryGirl.define do
  factory :designation do
    name { Faker::Job.title }
  end
end
