require "rails_helper"

describe ApplicationHelper do
  describe "#active_if" do
    it "returns 'inactive'" do
      expect(helper.active_if('controller')).to eq({ class: 'inactive' })
    end
    it "returns 'active'" do
      expect(helper.active_if('test')).to eq({ class: 'active' })
    end
  end
end