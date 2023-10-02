require 'rails_helper'

RSpec.describe "'Posts' - [Controller]", type: :request do
  describe "'GET /index' => 'index' action at 'posts' controller" do
    before { get user_posts_path({ user_id: 1 }) }

    context "* 'status'" do
      it '- returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/posts/show'
      expect(response).to have_http_status(:success)
    end
  end
end
