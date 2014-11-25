# == Schema Information
#
# Table name: registries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  disabled    :boolean
#  info        :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

describe Registry, :type => :model do
  let(:registry) { create(:registry) }
  describe '#scan' do
    it 'not raises error' do
      expect{ registry.scan }.to_not raise_error
    end
  end  
end
