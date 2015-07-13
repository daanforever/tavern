require "rails_helper"

RSpec.describe SettingsController, :type => :routing do
  describe "routing" do

    it "routes to #edit" do
      expect(:get => "/settings/edit").to route_to("settings#edit")
    end

    it "routes to #update" do
      expect(:put => "/settings").to route_to("settings#update")
    end

  end
end
