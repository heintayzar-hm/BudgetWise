require 'rails_helper'
require_relative '../support/controller_auth'


RSpec.describe ContractsController, type: :controller do
  extend ControllerAuth
  describe "GET #new" do
    context "when user is authenticated" do
      login_user

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end

      it "assigns the current user's groups to @groups" do
        get :new
        expect(assigns(:groups)).to eq(subject.current_user.groups)
      end

      it "assigns a new contract to @contract" do
        get :new
        expect(assigns(:contract)).to be_a_new(Contract)
      end
    end

    context "when user is not authenticated" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    login_user
    let(:group) { FactoryBot.create(:group, author: controller.current_user) }

    context "when user is authenticated" do

      context "with valid params" do
        let(:valid_attributes) { FactoryBot.attributes_for(:contract, group_id: group.id) }

        it "creates a new contract" do
          expect {
            post :create, params: { contract: valid_attributes }
          }.to change(Contract, :count).by(1)
        end

        it "assigns the new contract to the current user" do
          post :create, params: { contract: valid_attributes }
          expect(Contract.last.author).to eq(subject.current_user)
        end

        it "assigns the new contract to the selected group" do
          post :create, params: { contract: valid_attributes }
          expect(Contract.last.groups).to include(group)
        end

        it "redirects to the root path" do
          post :create, params: { contract: valid_attributes }
          expect(response).to redirect_to(root_path)
        end

        it "sets a success flash message" do
          post :create, params: { contract: valid_attributes }
          expect(flash[:notice]).to eq("Transaction created successfully.")
        end
      end

      context "with invalid params" do
        let(:invalid_attributes) { FactoryBot.attributes_for(:contract, name: nil, group_id: group.id) }

        it "does not create a new contract" do
          expect {
            post :create, params: { contract: invalid_attributes }
          }.to_not change(Contract, :count)
        end

        it "assigns the current user's groups to @groups" do
          post :create, params: { contract: invalid_attributes }
          expect(assigns(:groups)).to eq(subject.current_user.groups)
        end

        it "re-renders the new template" do
          post :create, params: { contract: invalid_attributes }
          expect(response).to render_template(:new)
        end

        it "sets an error flash message" do
          post :create, params: { contract: invalid_attributes }
          expect(flash[:alert]).to eq("Transaction creation failed")
        end
      end
    end
  end
end
