require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe ComponentsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Component. As you add validations to Component, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:component)
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ComponentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all components as @components" do
      component = Component.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:components)).to eq([component])
    end
  end

  describe "GET show" do
    it "assigns the requested component as @component" do
      component = Component.create! valid_attributes
      get :show, {:id => component.to_param}, valid_session
      expect(assigns(:component)).to eq(component)
    end
  end

  describe "GET edit" do
    it "assigns the requested component as @component" do
      component = Component.create! valid_attributes
      get :edit, {:id => component.to_param}, valid_session
      expect(assigns(:component)).to eq(component)
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        { name: Faker::Lorem.word }
      }

      it "updates the requested component" do
        component = Component.create! valid_attributes
        put :update, {:id => component.to_param, :component => new_attributes}, valid_session
        component.reload
        expect(component.name).to eq(new_attributes[:name])
      end

      it "assigns the requested component as @component" do
        component = Component.create! valid_attributes
        put :update, {:id => component.to_param, :component => valid_attributes}, valid_session
        expect(assigns(:component)).to eq(component)
      end

      it "redirects to the component" do
        component = Component.create! valid_attributes
        put :update, {:id => component.to_param, :component => valid_attributes}, valid_session
        expect(response).to redirect_to(component)
      end
    end

    describe "with invalid params" do
      it "assigns the component as @component" do
        component = Component.create! valid_attributes
        put :update, {:id => component.to_param, :component => invalid_attributes}, valid_session
        expect(assigns(:component)).to eq(component)
      end

      it "re-renders the 'edit' template" do
        component = Component.create! valid_attributes
        put :update, {:id => component.to_param, :component => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested component" do
      component = Component.create! valid_attributes
      expect {
        delete :destroy, {:id => component.to_param}, valid_session
      }.to change(Component, :count).by(-1)
    end

    it "redirects to the components list" do
      component = Component.create! valid_attributes
      delete :destroy, {:id => component.to_param}, valid_session
      expect(response).to redirect_to(components_url)
    end
  end

end
