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

def item
  OpenStruct.new({ 
    name: Faker::Lorem.word + '/' + Faker::Lorem.word,
    tags: [
      OpenStruct.new({
        name: Faker::Lorem.word,
        repository: OpenStruct.new({ full_name: Faker::Lorem.word }),
        docker_image: 64.times.map{ rand(0xf).to_s(16) }.join
      })
    ]
  })
end

describe Registry, :type => :model do
  let(:registry){ create(:registry) }

  let(:data) do
    [ item ]
  end

  before do
    stub_request(:any, /.*/).
      with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.9.1'})
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

    it 'set docker_id for image' do
      registry.parse( data )
      expect(Image.last.docker_id).to be(data.first.tags.first.image_id)
    end

    it 'creates only unique components' do
      item1 = item2 = item
      expect{ registry.parse( [ item1, item2 ] ) }.to change(Component, :count).by(1)
    end
  end # #parse

  describe '#refresh' do
    it 'not raises error' do
      expect{ registry.refresh }.to_not raise_error
    end
    it 'returns false with blank url' do
      registry.url = nil
      expect( registry.refresh ).to eq(false)
    end
    it 'returns updated registry' do
      word = Faker::Lorem.word
      expect( registry ).to receive( :scan ).and_return(true)
      expect( registry ).to receive( :parse ).and_return( word )
      expect( registry.refresh.info ).to eq( word )
    end
  end
end
