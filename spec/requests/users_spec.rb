require 'rails_helper'

RSpec.describe "'Users' - [Controller]", type: :request do
  describe "'GET /index' => 'index' action at 'users' controller", :index do
    before { get users_path }

    context "* 'status'", :status do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context "* 'template'", :template do
      it "- renders 'index' template" do
        expect(response).to render_template(:index)
        expect(response).to render_template('index')
      end

      it "- renders users/index' template" do
        expect(response).to render_template('users/index')
      end
    end

    context "* 'placeholder text'", :placeholder do
      it "- 'body' includes 'the list of Users'" do
        expect(response.body).to match(/the list of Users/)
      end
    end
  end

  describe "'GET /show' => 'show' action at 'users' controller", :show do
    before { get user_path({ id: 1 }) }

    context "* 'status'", :status do
      it '- returns http success/ok' do
        expect(response).to have_http_status(:success)
        expect(response).to have_http_status(:ok)
      end
    end

    context "* 'template'", :template do
      it "- renders 'show' template" do
        expect(response).to render_template(:show)
        expect(response).to render_template('show')
      end

      it "- renders 'users/show' template" do
        expect(response).to render_template('users/show')
      end
    end

    context "* 'placeholder text'", :placeholder do
      it "- 'body' includes 'Details for a User'" do
        expect(response.body).to match(/Details for a User/)
      end
    end
  end
end
