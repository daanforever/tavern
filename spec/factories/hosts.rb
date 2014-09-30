# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  disabled    :boolean
#  info        :text
#  created_at  :datetime
#  updated_at  :datetime
#

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
