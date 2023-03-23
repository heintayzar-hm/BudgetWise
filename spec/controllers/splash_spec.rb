require 'rails_helper'
require_relative '../support/controller_auth'

RSpec.describe SplashController, type: :controller do
  extend ControllerAuth
  describe "GET /" do
    login_user

    context 'when user is logged in' do
      it 'should return a 302 response' do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET / not log in" do
    context 'when user is not logged in' do
      it 'should return a 200 response' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
