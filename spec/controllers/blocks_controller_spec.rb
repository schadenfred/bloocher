require 'spec_helper'

describe BlocksController do

  def valid_attributes
    { "producer_id" => "1",
    "name" => "random block name" }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all blocks as @blocks" do
      block = Vineyard.create! valid_attributes
      get :index, {}, valid_session
      assigns(:blocks).should eq([block])
    end
  end

  describe "GET show" do
    it "assigns the requested block as @block" do
      block = Vineyard.create! valid_attributes
      get :show, {:id => block.to_param}, valid_session
      assigns(:block).should eq(block)
    end
  end

  describe "GET new" do
    it "assigns a new block as @block" do
      get :new, {}, valid_session
      assigns(:block).should be_a_new(Vineyard)
    end
  end

  describe "GET edit" do
    it "assigns the requested block as @block" do
      block = Vineyard.create! valid_attributes
      get :edit, {:id => block.to_param}, valid_session
      assigns(:block).should eq(block)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Block" do
        expect {
          post :create, {:block => valid_attributes}, valid_session
        }.to change(Vineyard, :count).by(1)
      end

      it "assigns a newly created block as @block" do
        post :create, {:block => valid_attributes}, valid_session
        assigns(:block).should be_a(Vineyard)
        assigns(:block).should be_persisted
      end

      it "redirects to the created block" do
        post :create, {:block => valid_attributes}, valid_session
        response.should redirect_to(Vineyard.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved block as @block" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vineyard.any_instance.stub(:save).and_return(false)
        post :create, {:block => {  }}, valid_session
        assigns(:block).should be_a_new(Vineyard)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vineyard.any_instance.stub(:save).and_return(false)
        post :create, {:block => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested block" do
        block = Vineyard.create! valid_attributes
        # Assuming there are no other blocks in the database, this
        # specifies that the Block created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Vineyard.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update, {:id => block.to_param, :block => { "these" => "params" }}, valid_session
      end

      it "assigns the requested block as @block" do
        block = Vineyard.create! valid_attributes
        put :update, {:id => block.to_param, :block => valid_attributes}, valid_session
        assigns(:block).should eq(block)
      end

      it "redirects to the block" do
        block = Vineyard.create! valid_attributes
        put :update, {:id => block.to_param, :block => valid_attributes}, valid_session
        response.should redirect_to(block)
      end
    end

    describe "with invalid params" do
      it "assigns the block as @block" do
        block = Vineyard.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vineyard.any_instance.stub(:save).and_return(false)
        put :update, {:id => block.to_param, :block => {  }}, valid_session
        assigns(:block).should eq(block)
      end

      it "re-renders the 'edit' template" do
        block = Vineyard.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vineyard.any_instance.stub(:save).and_return(false)
        put :update, {:id => block.to_param, :block => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested block" do
      block = Vineyard.create! valid_attributes
      expect {
        delete :destroy, {:id => block.to_param}, valid_session
      }.to change(Vineyard, :count).by(-1)
    end

    it "redirects to the blocks list" do
      block = Vineyard.create! valid_attributes
      delete :destroy, {:id => block.to_param}, valid_session
      response.should redirect_to(blocks_url)
    end
  end

end