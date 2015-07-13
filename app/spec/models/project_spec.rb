# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  visible     :boolean
#  disabled    :boolean
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Project, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end
