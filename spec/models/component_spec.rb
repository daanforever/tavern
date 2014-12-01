# == Schema Information
#
# Table name: components
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  disabled    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

require 'rails_helper'

RSpec.describe Component, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
