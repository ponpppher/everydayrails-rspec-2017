require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe '#index' do

    context 'as an authenticated user' do
      before do
        @user = FactoryBot.create(:user)
      end

      it 'responds successfully' do
        sign_in(@user)
        get :index
        expect(response).to be_success
      end

      it 'reuturn a 200 code' do
        sign_in(@user)
        get :index
        expect(response).to have_http_status '200'
      end
    end

    context 'as guest user' do
      it 'reuturn a 302 code' do
        get :index
        expect(response).to have_http_status '302'
      end

      it 'redirects to the sign-in page' do
        get :index
        expect(response).to redirect_to '/users/sign_in'
      end
    end
  end

  describe '#show' do
    context 'as an authorized user' do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end

      it 'responds successfully' do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to be_success
      end
    end

    context 'as an unauthorized user' do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: other_user)
      end

      it 'redirected to the dashboard' do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to have_http_status '302'
      end
    end
  end
end
