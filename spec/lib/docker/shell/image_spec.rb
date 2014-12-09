
require 'rails_helper'

describe Docker::Shell::Image do
  let(:instance){ create(:instance) }
  let(:image){ Docker::Shell.new(instance: instance).image }

  describe '#exist?' do
    context 'when image exist' do
      it 'not raises error' do
        expect(Docker::Image).to receive(:get).and_return(true)
        expect{ image.exist? }.to_not raise_error
      end
      it 'returns true' do
        expect(Docker::Image).to receive(:get).and_return(true)
        expect( image.exist? ).to eq(true)
      end
    end # when image present
    context 'when image empty' do
      it 'returns false on exception' do
        expect(Docker::Image).to receive(:exist?){ raise }
        expect( image.exist? ).to eq(false)        
      end
      it 'returns false on nil' do
        expect(Docker::Image).to receive(:exist?).and_return(false)
        expect( image.exist? ).to eq(false)        
      end
    end # when image present
  end # #exist?

  describe '#pull' do
    it 'not raises error' do
      expect(Docker::Image).to receive(:create).and_return(true)
      expect{ image.pull }.to_not raise_error
    end

    it 'returns true on success pull' do
      expect(Docker::Image).to receive(:create).and_return(true)
      expect( image.pull ).to eq(true)
    end

    it 'returns false on pull error' do
      expect(Docker::Image).to receive(:create){ raise }
      expect( image.pull ).to eq(false)
    end
  end
end
