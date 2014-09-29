# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    name "MyString"
    disabled false
    registry nil
    project nil
    release nil
    component nil
  end
end
