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
      instance = create(:instance, state: :stopped)
      expect( instance.start ).to_not eq(nil)
    end
  end

  describe '#start!' do

    let(:instance){ create(:instance, state: :starting) }

    before do
      stub_request(:post, /.*/).
        with(:headers => {'Content-Type'=>'application/json'}).
        to_return(:status => 404, :body => "", :headers => {})
    end

    it 'returns nil for invalid state' do
      instance = create(:instance, state: :stopped)
      expect( instance.start! ).to eq(nil)
    end

    context 'with container ID' do
      it 'raises NotImplementedError' do
        instance = create(:instance, state: :starting, container: '123')
        expect{ instance.start! }.to raise_error(NotImplementedError)
      end
    end

    context 'without container ID' do

      it 'not raises error' do
        instance = create(:instance)
        expect{ instance.start! }.to_not raise_error
      end

      it 'change state from "starting" to "running"' do
        instance = create(:instance, state: :starting)
        instance.start!
        expect(instance.state.to_sym).to eq(:running)
      end


    end

  end

end
