# == Schema Information
#
# Table name: hosts
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  url            :string(255)
#  disabled       :boolean
#  info           :text
#  created_at     :datetime
#  updated_at     :datetime
#  environment_id :integer
#

require 'rails_helper'

RSpec.describe Host, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
