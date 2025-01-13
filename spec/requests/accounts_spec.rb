require 'rails_helper'

RSpec.describe "Accounts", type: :request do
  describe "GET /" do
    context 'when signed in' do
      before do
        sign_in create(:user)
      end
      it 'returns http success' do
        get root_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'when not signed in' do
      it 'redirects to the sign in page' do
        get root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
