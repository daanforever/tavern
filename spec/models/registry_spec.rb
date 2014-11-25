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
  let(:registry){ create(:registry) }

  let(:data) do
    [
      OpenStruct.new({ 
        name: Faker::Lorem.word + '/' + Faker::Lorem.word,
        tags: [
          OpenStruct.new({
            name: Faker::Lorem.word,
            repository: OpenStruct.new({ full_name: Faker::Lorem.word })
          })
        ]
      })
    ]
  end

  describe '#scan' do
    it 'not raises error' do
      expect{ registry.scan }.to_not raise_error
    end
  end

  describe '#parse' do
    it 'not raises error' do
      expect{ registry.parse( data ) }.to_not raise_error
    end

    it 'returns not nil' do
      expect( registry.parse( data ) ).to_not be_nil
    end

    it 'creates new Project' do
      expect{ registry.parse( data ) }.to change(Project, :count).by(1)
    end

    it 'creates new Release' do
      expect{ registry.parse( data ) }.to change(Release, :count).by(1)
    end

    it 'creates new Component' do
      expect{ registry.parse( data ) }.to change(Component, :count).by(1)
    end

    it 'creates new Image' do
      expect{ registry.parse( data ) }.to change(Image, :count).by(1)
    end
  end
end
