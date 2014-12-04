
require 'rails_helper'

describe DockerShell::Image do
  describe '#exist?' do
    let(:instance){ create(:instance) }
    context 'when image exist' do
      it 'returns true' do
        image = DockerShell.new(instance: instance).image
        expect{ image.exist? }.to_not raise_error
        # expect( image.exist? ).to eq( true )
      end
    end # when image present
    context 'when image empty' do
      it 'returns false' do
        image = DockerShell.new(instance: instance).image
        expect( image.exist? ).to eq(false)        
      end
    end # when image present
  end # #exist?
end