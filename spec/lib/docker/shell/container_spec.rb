require 'rails_helper'

describe Docker::Shell::Container do
  let(:instance){ create(:instance) }
  let(:container){ Docker::Shell.new(instance: instance).container }
  let(:docker_container){ double(Docker::Container) }
  let(:docker_container_id){ rand(9999) }
  
  before{ allow( docker_container ).to receive(:id).and_return( docker_container_id ) }
  
  describe '#exist?' do
    it 'not raises error' do
      expect{ container.exist? }.to_not raise_error
    end
    context 'when container present' do
      it 'returns false if instance.container.blank?' do
        expect( container.exist? ).to eq(false)
      end
      it 'returns false if container not present' do
        instance.update(container: rand(1000))
        expect( Docker::Container ).to receive(:get).and_return(false)
        expect( container.exist? ).to eq(false)
      end
      it 'returns true if container present' do
        instance.update(container: rand(1000))
        expect( Docker::Container ).to receive(:get).and_return( docker_container )
        expect( container.exist? ).to eq( true )
      end
    end # when container present

    context 'when container empty' do
      it 'returns false' do
        expect( container.exist? ).to eq(false)        
      end
    end # when container present
  end # #exist?

  describe '#start' do
    context 'when container exist' do
      it 'not raises error' do
        expect{ container.start }.to_not raise_error
      end
      it 'returns instance ID if Docker return no errors' do
        expect( Docker::Container ).to receive(:create).and_return( docker_container )
        expect( docker_container ).to receive(:start).and_return( docker_container )
        expect( container.start ).to eq( docker_container_id )
      end
      it 'returns false on errors' do
        expect( Docker::Container ).to receive(:create).and_return( docker_container )
        expect( docker_container ).to receive(:start){ raise }
        expect( container.start ).to eq( false )
      end
    end
    context 'when container not exist' do
      it 'call #create' do
        expect( container ).to receive(:exist?).and_return(false)
        expect( container ).to receive(:create).and_return(docker_container)
        expect{ container.start }.to_not raise_error
      end
    end
  end

  describe '#create' do
    context 'when image exist' do
      it 'returns true if Docker return no errors' do
        expect( Docker::Container ).to receive(:create).and_return( docker_container )
        allow( docker_container ).to receive(:id).and_return( docker_container_id )
        expect( container.create.id ).to eq( docker_container_id )
      end
      it 'returns false on exception' do
        expect( Docker::Container ).to receive(:create){ raise }
        expect( container.create ).to eq(false)
      end
      it 'returns false on errors' do
        expect( Docker::Container ).to receive(:create).and_return( false )
        expect( container.create ).to eq(false)
      end
    end
    context 'when image not exist' do
      it 'returns false' do
        expect( Docker::Container ).to receive(:create){ raise }
        expect( container.create ).to eq(false)
      end
    end
  end

  describe '#stop' do
    before do
      allow( Docker::Container ).to receive(:get).and_return( docker_container )
    end

    it 'not raises error' do
      expect{ container.stop }.to_not raise_error
    end
    it 'returns false if container is nil' do
      expect( container.stop ).to eq(false)
    end
    it 'returns false if container is nil' do
      expect( container.stop ).to eq(false)
    end
    it 'returns true if stopped' do
      instance.update(container: docker_container_id)
      expect( docker_container ).to receive(:stop).and_return( true )
      expect( container.stop ).to eq(true)
    end
    it 'returns false if failed to stop' do
      instance.update(container: docker_container_id)
      expect( docker_container ).to receive(:stop).and_return( false )
      expect( container.stop ).to eq(false)
    end
    it 'returns false on exception' do
      instance.update(container: docker_container_id)
      expect( docker_container ).to receive(:stop){ raise }
      expect( container.stop ).to eq(false)
    end
  end

  describe '#get' do
    before do
      allow( Docker::Container ).to receive(:get).and_return( docker_container )
    end

    it 'not raises error' do
      expect{ container.get }.to_not raise_error
    end
    it 'returns Docker::Container' do
      instance.container = docker_container_id
      expect( container.get ).to eq(docker_container)
    end
    it 'returns false without @instance.container' do
      expect( container.get ).to eq(false)
    end
    it 'returns false on exception' do
      instance.container = docker_container_id
      expect( Docker::Container ).to receive(:get){ raise }
      expect( container.get ).to eq(false)
    end
  end

end
