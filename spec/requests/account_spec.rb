require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/accounts/home"
      expect(response).to have_http_status(:success)
    end
  end

end
