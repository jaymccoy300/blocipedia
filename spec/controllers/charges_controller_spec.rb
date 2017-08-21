require 'rails_helper'

RSpec.describe ChargesController, type: :controller do

  describe "GET #create" do
    login_user
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    login_user
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

end
