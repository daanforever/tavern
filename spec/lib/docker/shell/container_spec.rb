require 'rails_helper'

describe Docker::Shell::Container do
  let(:instance){ create(:instance) }
  describe '#exist?' do
    it 'not raises error' do
      container = Docker::Shell.new(instance: instance).container
      expect{ container.exist? }.to_not raise_error
      # expect( container.exist? ).to eq( true )
    end
    context 'when container present' do
      it 'returns false if instance.container.blank?' do
        container = Docker::Shell.new(instance: instance).container
        expect( container.exist? ).to eq(false)
        # expect( container.exist? ).to eq( true )
      end
      it 'returns false if container not present' do
        instance.update(container: rand(1000))
        container = Docker::Shell.new(instance: instance).container
        expect( Docker::Container ).to receive(:get).and_return(false)
        expect( container.exist? ).to eq(false)
        # expect( container.exist? ).to eq( true )
      end
      it 'returns true if container present' do
        instance.update(container: rand(1000))
        container = Docker::Shell.new(instance: instance).container
        expect( Docker::Container ).to receive(:get).and_return(true)
        expect( container.exist? ).to eq(true)
        # expect( container.exist? ).to eq( true )
      end
    end # when container present

    context 'when container empty' do
      it 'returns false' do
        container = Docker::Shell.new(instance: instance).container
        expect( container.exist? ).to eq(false)        
      end
    end # when container present
  end # #exist?

  describe '#start' do
    context 'when container exist' do
      it 'not raises error' do
        container = Docker::Shell.new(instance: instance).container
        expect{ container.start }.to_not raise_error
      end
      it 'returns instance ID if Docker return no errors' do
        container = Docker::Shell.new(instance: instance).container
        docker_container = double(Docker::Container)
        instance_id      = rand(9999)
        expect( Docker::Container ).to receive(:create).and_return( docker_container )
        expect( docker_container ).to receive(:start).and_return( true )
        allow( docker_container ).to receive(:id).and_return( instance_id )
        expect( container.start ).to eq(instance_id)
      end
      it 'returns false on errors'
    end
    context 'when container not exist' do
      it 'call #create'
      it 'returns true if Docker return no errors'
      it 'returns false on errors'
    end
  end

  describe '#create' do
    context 'when image exist' do
      it 'returns true if Docker return no errors'
      it 'returns false on errors'
    end
    context 'when image not exist' do
      it 'returns true if Docker return no errors'
      it 'returns false on errors'
    end
  end
end
