# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  public_port    :integer
#  container      :string(255)
#  properties     :text
#  image_id       :integer
#  component_id   :integer
#  host_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  state          :integer
#  environment_id :integer
#  private_port   :integer
#  options        :text
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :instance do
    name            { Faker::Name.name }
    disabled        false
    public_port     { rand(65535) }
    private_port    { rand(65535) }
    container       { Faker::Name.name }
    properties      { Faker::Lorem.paragraph }
    component_id    { create(:component).id }
    image_id        { create(:image, component: component).id }
    host_id         { create(:host).id }
    environment_id  { create(:environment).id }
    options         { Faker::Lorem.paragraph }
  end
end
