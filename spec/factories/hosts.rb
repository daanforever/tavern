# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    name "MyString"
    description "MyString"
    url "MyString"
    disabled false
    info "MyText"
  end
end
