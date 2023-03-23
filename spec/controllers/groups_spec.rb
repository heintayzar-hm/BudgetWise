require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe GroupsController, type: :controller do
  extend ControllerAuth
  let(:user) { controller.current_user }
  let(:group) { FactoryBot.create(:group, author: controller.current_user) }

  describe "GET #index" do
    login_user

    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end


  describe "POST #create" do
    context "when user is not signed in" do
      it "redirects to the sign in page" do
        post :create, params: { group: { name: "Test Group" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is signed in" do
      login_user

      context "with valid params" do
        it "creates a new group" do
          expect {
            post :create, params: { group: { name: "Test Group" } }
          }.to change(Group, :count).by(1)
        end

        it "redirects to the root path" do
          post :create, params: { group: { name: "Test Group" } }
          expect(response).to redirect_to(root_path)
        end
      end

      context "with invalid params" do
        it "renders the new template" do
          post :create, params: { group: { name: "" } }
          expect(response).to render_template(:new)
        end
      end
    end
  end

  describe "GET #show" do
    login_user
    context "when the group exists" do
      it "assigns the requested group to @group" do
        get :show, params: { id: group.id }
        expect(assigns(:group)).to eq(group)
      end

      it "assigns contracts to @contracts" do
        contract1 = FactoryBot.create(:contract, author: user)
        contract2 = FactoryBot.create(:contract, author: user)

        group.contracts << contract1
        group.contracts << contract2
        get :show, params: { id: group.id }
        expect(assigns(:contracts)).to eq([contract2, contract1])
      end

      it "renders the show template" do
        get :show, params: { id: group.id }
        expect(response).to render_template(:show)
      end
    end

    context "when the group does not exist" do
      it "redirects to the root path" do
        get :show, params: { id: 999 }
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
