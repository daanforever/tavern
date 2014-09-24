# == Schema Information
#
# Table name: registries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :string(255)
#  url        :string(255)
#  disabled   :boolean
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registry do
    name "MyString"
    desc "MyString"
    url "MyString"
    disabled false
  end
end
