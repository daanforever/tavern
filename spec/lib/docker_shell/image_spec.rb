
require 'rails_helper'

describe DockerShell::Image do
  describe '#exist?' do
    let(:instance){ create(:instance) }
    context 'when image exist' do
      it 'not raises error' do
        expect(Docker::Image).to receive(:get).and_return(true)
        image = DockerShell.new(instance: instance).image
        expect{ image.exist? }.to_not raise_error
      end
      it 'returns true' do
        expect(Docker::Image).to receive(:get).and_return(true)
        image = DockerShell.new(instance: instance).image
        expect( image.exist? ).to eq( true )
      end
    end # when image present
    context 'when image empty' do
      it 'returns false on exception' do
        expect(Docker::Image).to receive(:exist?){ raise }
        image = DockerShell.new(instance: instance).image
        expect( image.exist? ).to eq(false)        
      end
      it 'returns false on nil' do
        expect(Docker::Image).to receive(:exist?).and_return(false)
        image = DockerShell.new(instance: instance).image
        expect( image.exist? ).to eq(false)        
      end
    end # when image present
  end # #exist?
end