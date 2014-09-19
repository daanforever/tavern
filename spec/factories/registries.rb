# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registry do
    name "MyString"
    desc "MyString"
    url "MyString"
    disabled false
  end
end
