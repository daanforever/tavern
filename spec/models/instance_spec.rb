# == Schema Information
#
# Table name: instances
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  disabled       :boolean
#  public_port    :integer
#  container      :string(255)
#  properties     :text
#  image_id       :integer
#  component_id   :integer
#  host_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#  state          :integer
#  environment_id :integer
#  private_port   :integer
#  options        :text
#

require 'rails_helper'

RSpec.describe Instance, :type => :model do

  describe 'common cases' do

    let(:instance){ create(:instance) }

    it 'instance should have ID' do
      expect(instance.id).to_not eq(nil)
    end
  end

  describe '#start' do
    let(:instance){ create(:instance, state: :starting) }
    let(:container){ double(Docker::Shell::Container).as_null_object }
    let(:image){ double(Docker::Shell::Images).as_null_object }
    
    before do
      allow(Docker::Shell::Container).to receive(:new).and_return(container)
      allow(Docker::Shell::Images).to receive(:new).and_return(image)
    end

    it 'returns false for invalid state' do
      instance = create(:instance, state: :starting)
      expect( instance.start ).to eq(false)
    end

    it 'change valid states' do
      instance = create(:instance, state: :stopped)
      delay = double( Instance )
      expect( instance ).to receive( :delay ).and_return( delay )
      expect( delay ).to receive( :start! )
      instance.start
      expect( instance.state.to_sym ).to eq(:starting)
    end
  end

  describe '#start!' do

    let(:instance){ create(:instance, state: :starting) }
    let(:container){ double(Docker::Shell::Container) }
    let(:image){ double(Docker::Shell::Images) }
    
    before do
      allow(Docker::Shell::Container).to receive(:new).and_return(container)
      allow(Docker::Shell::Images).to receive(:new).and_return(image)
    end

    context 'with container ID' do
      let(:instance){ create(:instance, state: :starting, container: rand(1..1000)) }
      context 'when container already running' do
        it 'change state' do
          expect(container).to receive(:exist?).and_return(true)
          expect(container).to receive(:running?).and_return(true)

          instance.start!
          expect(instance.state.to_sym).to eq(:running)
        end
      end
      context 'when container started' do
        it 'change state' do
          expect(container).to receive(:exist?).and_return(true)
          expect(container).to receive(:running?).and_return(false)
          expect(container).to receive(:start).and_return(true)

          instance.start!
          expect(instance.state.to_sym).to eq(:running)
        end
      end

      context 'when starting error' do
        it 'change state' do
          expect(container).to receive(:exist?).and_return(true)
          expect(container).to receive(:running?).and_return(false)
          expect(container).to receive(:start).and_return(false)

          instance.start!
          expect(instance.state.to_sym).to eq(:failed)
        end
      end
    end

    context 'without container ID' do

      context 'when image exist' do
        context 'and container started' do
          it 'change state' do
            expect(container).to receive(:exist?).and_return(false)
            expect(image).to receive(:exist?).twice.and_return(true)
            expect(container).to receive(:start).and_return(true)
            instance.start!
            expect(instance.state.to_sym).to eq(:running)
          end
        end # and container started
        context 'and container not started' do
          it 'change state' do
            expect(container).to receive(:exist?).and_return(false)
            expect(image).to receive(:exist?).twice.and_return(true)
            expect(container).to receive(:start).and_return(false)
            instance.start!
            expect(instance.state.to_sym).to eq(:failed)
          end
        end
      end # when image exist

      context 'when image does not exist' do
        context 'but pulled' do
          context 'and container started' do
            it 'change state' do
              expect(container).to receive(:exist?).and_return(false)
              expect(image).to receive(:exist?).and_return(false)
              expect(image).to receive(:exist?).and_return(true)
              expect(image).to receive(:pull).and_return(true)
              expect(container).to receive(:start).and_return(true)
              instance.start!
              expect(instance.state.to_sym).to eq(:running)
            end
          end # and container started
        end # but pulled
        context 'and not pulled' do
          it 'change state' do
            expect(container).to receive(:exist?).and_return(false)
            expect(image).to receive(:exist?).twice.and_return(false)
            expect(image).to receive(:pull).and_return(false)
            instance.start!
            expect(instance.state.to_sym).to eq(:failed)
          end
        end # and not pulled
      end # when image does not exist
    end # without container ID

  end # #start!

  describe '#stop' do
    let(:instance){ create(:instance, state: :running) }
    
    it 'returns false for invalid state' do
      instance = create(:instance, state: :starting)
      expect( instance.stop ).to eq(false)
    end

    it 'change valid states' do
      delay = double( Instance )
      expect( instance ).to receive( :delay ).and_return( delay )
      expect( delay ).to receive( :stop! )
      instance.stop
      expect( instance.state.to_sym ).to eq(:stopping)
    end
  end

  describe '#stop!' do
    let(:instance){ create(:instance, state: :stopping) }
    let(:container){ double(Docker::Shell::Container) }

    before{ expect( Docker::Shell::Container ).to receive( :new ).and_return( container ) }

    context 'when container.stop returns false' do
      it 'not changes state' do
        expect( container ).to receive( :stop ).and_return( false )
        expect{ instance.stop! }.to_not raise_error
        expect(instance.state.to_sym).to eq(:stopping)
      end
    end
    context 'when container.stop returns true' do
      it 'changes state' do
        expect( container ).to receive( :stop ).and_return( true )
        expect{ instance.stop! }.to_not raise_error
        expect(instance.state.to_sym).to eq(:stopped)
      end
    end
  end

  describe '#docker' do
    let(:instance){ create(:instance) }

    it 'not raises error' do
      expect{ instance.docker }.to_not raise_error
    end
  end

end
