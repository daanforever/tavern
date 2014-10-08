# == Schema Information
#
# Table name: environments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  project_id :integer
#  release_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Environment, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
