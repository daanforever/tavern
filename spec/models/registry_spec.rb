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

require 'rails_helper'

describe Registry, :type => :model do
  
end
