require 'rails_helper'

RSpec.describe "'Users' - [Controller]", type: :request do
  describe "'GET /index' => 'index' action at 'users' controller" do
    before { get users_path }

    context "* 'status'" do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context "* 'template'" do
      it "- renders 'index' template" do
        expect(response).to render_template(:index)
        expect(response).to render_template('index')
      end

      it "- renders users/index' template" do
        expect(response).to render_template('users/index')
      end
    end

    context "* 'placeholder text'" do
      it "- 'body' includes 'list of all Users'" do
        expect(response.body).to match(/the list of Users/)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/show'
      expect(response).to have_http_status(:success)
    end
  end
end
