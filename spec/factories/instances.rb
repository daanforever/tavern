# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instance do
    name "MyString"
    disabled false
    port 1
    container "MyString"
    properties "MyText"
    image nil
    component nil
    host nil
  end
end
