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

RSpec.describe HostsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Host. As you add validations to Host, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    attributes_for(:host)
  }

  let(:valid_request) {
    {
      host: valid_attributes,
      environment_id: valid_attributes[:environment_id]
    }
  }


  let(:invalid_attributes) {
    attributes_for(:host, url: nil)
  }

  let(:invalid_request) {
    {
      host: attributes_for(:host, url: nil),
      environment_id: valid_attributes[:environment_id]
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HostsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all hosts as @hosts" do
      host = Host.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:hosts)).to eq([host])
    end
  end

  describe "GET show" do
    it "assigns the requested host as @host" do
      host = Host.create! valid_attributes
      get :show, {:id => host.to_param}, valid_session
      expect(assigns(:host)).to eq(host)
    end
  end

  describe "GET new" do
    it "assigns a new host as @host" do
      get :new, { environment_id: valid_attributes[:environment_id] }, valid_session
      expect(assigns(:host)).to be_a_new(Host)
    end
  end

  describe "GET edit" do
    it "assigns the requested host as @host" do
      host = Host.create! valid_attributes
      get :edit, {:id => host.to_param}, valid_session
      expect(assigns(:host)).to eq(host)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Host" do
        expect {
          post :create, valid_request, valid_session
        }.to change(Host, :count).by(1)
      end

      it "assigns a newly created host as @host" do
        post :create, valid_request, valid_session
        expect(assigns(:host)).to be_a(Host)
        expect(assigns(:host)).to be_persisted
      end

      it "redirects to the created host" do
        post :create, valid_request, valid_session
        expect(response).to redirect_to(Environment.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved host as @host" do
        post :create, invalid_request, valid_session
        expect(assigns(:host)).to be_a_new(Host)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        attributes_for(:host)
      }

      it "updates the requested host" do
        host = Host.create! valid_attributes
        put :update, {:id => host.to_param, :host => new_attributes}, valid_session
        host.reload
        expect(assigns(:host)).to eq(host)
      end

      it "assigns the requested host as @host" do
        host = Host.create! valid_attributes
        put :update, {:id => host.to_param, :host => valid_attributes}, valid_session
        expect(assigns(:host)).to eq(host)
      end

      it "redirects to the host" do
        host = Host.create! valid_attributes
        put :update, {:id => host.to_param, :host => valid_attributes}, valid_session
        expect(response).to redirect_to(host)
      end
    end

    describe "with invalid params" do
      it "assigns the host as @host" do
        host = Host.create! valid_attributes
        put :update, {:id => host.to_param, :host => invalid_attributes}, valid_session
        expect(assigns(:host)).to eq(host)
      end

      it "re-renders the 'edit' template" do
        host = Host.create! valid_attributes
        put :update, {:id => host.to_param, :host => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested host" do
      host = Host.create! valid_attributes
      expect {
        delete :destroy, {:id => host.to_param}, valid_session
      }.to change(Host, :count).by(-1)
    end

    it "redirects to the hosts list" do
      host = Host.create! valid_attributes
      delete :destroy, {:id => host.to_param}, valid_session
      expect(response).to redirect_to(environments_url)
    end
  end

end
