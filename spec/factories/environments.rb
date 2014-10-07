# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :environment do
    name "MyString"
    project nil
    release nil
  end
end
