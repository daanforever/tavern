# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  disabled     :boolean
#  registry_id  :integer
#  project_id   :integer
#  release_id   :integer
#  component_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Image, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
