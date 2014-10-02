# == Schema Information
#
# Table name: releases
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  label       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#  state       :integer
#

require 'rails_helper'

RSpec.describe Release, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
