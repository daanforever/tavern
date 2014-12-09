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
    it 'returns nil for invalid state' do
      instance = create(:instance, state: :starting)
      expect( instance.start ).to eq(nil)
    end

    it 'change valid states' do
      skip
      instance = create(:instance, state: :stopped)
      expect( instance.start ).to_not eq(nil)
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

    it 'returns nil for invalid state' do
      instance = create(:instance, state: :stopped)
      expect( instance.start! ).to eq(nil)
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

      it 'not raises error' do
        instance = create(:instance)
        expect{ instance.start! }.to_not raise_error
      end

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

end
