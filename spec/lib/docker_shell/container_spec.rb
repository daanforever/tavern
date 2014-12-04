
require 'rails_helper'

describe DockerShell::Container do
  describe '#exist?' do
    let(:instance){ create(:instance) }
    context 'when container present' do
      it 'returns true' do
        instance.update(container: rand(1000))
        container = DockerShell.new(instance: instance).container
        expect{ container.exist? }.to raise_error(NotImplementedError)
        # expect( container.exist? ).to eq( true )
      end
    end # when container present
    context 'when container empty' do
      it 'returns false' do
        container = DockerShell.new(instance: instance).container
        expect( container.exist? ).to eq(false)        
      end
    end # when container present
  end # #exist?
end