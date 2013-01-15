require 'spec_helper'

describe WinesController do

  # This should return the minimal set of attributes required to create a valid
  # Wine. As you add validations to Wine, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { vintage: "1984",
      name: "methode ancien chardonnay",
      cases_produced: "1", 
      winery_id: "1"
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WinesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all wines as @wines" do
      wine = Wine.create! valid_attributes
      get :index, {}, valid_session
      assigns(:wines).should eq([wine])
    end
  end

  describe "GET show" do
    it "assigns the requested wine as @wine" do
      wine = Wine.create! valid_attributes
      get :show, {:id => wine.to_param}, valid_session
      assigns(:wine).should eq(wine)
    end
  end

  describe "GET new" do
    it "assigns a new wine as @wine" do
      get :new, {}, valid_session
      assigns(:wine).should be_a_new(Wine)
    end
  end

  describe "GET edit" do
    it "assigns the requested wine as @wine" do
      wine = Wine.create! valid_attributes
      get :edit, {:id => wine.to_param}, valid_session
      assigns(:wine).should eq(wine)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Wine" do
        expect {
          post :create, {:wine => valid_attributes}, valid_session
        }.to change(Wine, :count).by(1)
      end

      it "assigns a newly created wine as @wine" do
        post :create, {:wine => valid_attributes}, valid_session
        assigns(:wine).should be_a(Wine)
        assigns(:wine).should be_persisted
      end

      it "redirects to the created wine" do
        post :create, {:wine => valid_attributes}, valid_session
        response.should redirect_to(Wine.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved wine as @wine" do
        # Trigger the behavior that occurs when invalid params are submitted
        Wine.any_instance.stub(:save).and_return(false)
        post :create, {:wine => { "vintage" => "invalid value" }}, valid_session
        assigns(:wine).should be_a_new(Wine)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Wine.any_instance.stub(:save).and_return(false)
        post :create, {:wine => { "vintage" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested wine" do
        wine = Wine.create! valid_attributes
        # Assuming there are no other wines in the database, this
        # specifies that the Wine created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Wine.any_instance.should_receive(:update_attributes).with({ "vintage" => "1" })
        put :update, {:id => wine.to_param, :wine => { "vintage" => "1" }}, valid_session
      end

      it "assigns the requested wine as @wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => valid_attributes}, valid_session
        assigns(:wine).should eq(wine)
      end

      it "redirects to the wine" do
        wine = Wine.create! valid_attributes
        put :update, {:id => wine.to_param, :wine => valid_attributes}, valid_session
        response.should redirect_to(wine)
      end
    end

    describe "with invalid params" do
      it "assigns the wine as @wine" do
        wine = Wine.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Wine.any_instance.stub(:save).and_return(false)
        put :update, {:id => wine.to_param, :wine => { "vintage" => "invalid value" }}, valid_session
        assigns(:wine).should eq(wine)
      end

      it "re-renders the 'edit' template" do
        wine = Wine.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Wine.any_instance.stub(:save).and_return(false)
        put :update, {:id => wine.to_param, :wine => { "vintage" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested wine" do
      wine = Wine.create! valid_attributes
      expect {
        delete :destroy, {:id => wine.to_param}, valid_session
      }.to change(Wine, :count).by(-1)
    end

    it "redirects to the wines list" do
      wine = Wine.create! valid_attributes
      delete :destroy, {:id => wine.to_param}, valid_session
      response.should redirect_to(wines_url)
    end
  end

end
