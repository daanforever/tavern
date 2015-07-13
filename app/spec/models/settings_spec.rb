# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Settings, :type => :model do
  
end
