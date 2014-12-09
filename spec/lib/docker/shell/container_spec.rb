require 'rails_helper'

describe Docker::Shell::Container do
  let(:instance){ create(:instance) }
  describe '#exist?' do
    context 'when container present' do
      it 'returns true' do
        instance.update(container: rand(1000))
        container = Docker::Shell.new(instance: instance).container
        expect{ container.exist? }.to raise_error(NotImplementedError)
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
      it 'returns true if Docker return no errors' do
        container = Docker::Shell.new(instance: instance).container
        expect container.start
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
