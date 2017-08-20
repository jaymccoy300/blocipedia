require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do


  describe "GET #index" do
    login_user
    it "returns http index success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #about" do
    login_user
    it "returns http about success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

end
