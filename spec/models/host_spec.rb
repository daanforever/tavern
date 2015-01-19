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

describe Host, :type => :model do
  let(:host){ create(:host) }
  describe '#refresh' do
    it 'not raises error' do
      expect( Docker::Container ).to receive( :all ).and_return({})
      expect{ host.refresh }.to_not raise_error
    end
    it 'returns array' do
      containers = [ OpenStruct.new({id: rand(9999)}) ]
      container = double( Docker::Container )
      info = { 'Config' => { 'Image' => Faker::Lorem.word }, 'State' => { 'Running' => true } }
      expect( Docker::Container ).to receive( :all ).and_return(containers)
      expect( Docker::Container ).to receive( :get ).and_return(container)
      expect( container ).to receive( :info ).twice.and_return(info)
      expect( host.refresh ).to be_a(Array)
    end
  end  

  describe '#docker' do
    it
  end
end
