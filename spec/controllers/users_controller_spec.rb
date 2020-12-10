# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController do
  let(:email) { 'username@email.com' }
  let(:password) { 'password' }
  let(:user) { User.create(email: email, password: password) }

  describe 'GET index' do
    it 'assigns @users' do
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET new' do
    before do
      allow(User).to receive(:new).and_return(user)
    end

    it 'assigns a new user' do
      get :new
      assigns(:user).should == user
    end

    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end

    it 'renders the index template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST create' do
    context 'valid params sent' do
      let(:valid_params) { { email: 'username@email.com', password: password } }

      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the new contact' do
        post :create, params: { user: valid_params }
        response.should redirect_to User.last
      end

      it 'has a 302 status code' do
        post :create, params: { user: valid_params }
        expect(response.status).to eq(302)
      end
    end

    context 'invalid params sent' do
      let(:invalid_params) { { email: 'username@email.com', password: '' } }

      it 'does not create a new user' do
        expect do
          post :create, params: { user: invalid_params }
        end.to_not change(User, :count)
      end

      it 'redirects to the new template' do
        post :create, params: { user: invalid_params }
        expect(response).to render_template('new')
      end

      it 'has a 200 status code' do
        post :create, params: { user: invalid_params }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'PATCH update' do
    context 'valid params sent' do
      let(:updated_email) { 'username@email.com' }
      let(:valid_params) { { email: updated_email } }

      it 'creates a new user' do
        patch :update, params: { id: user.id, user: valid_params }
        user.reload
        expect(user.email).to eq(updated_email)
      end

      it 'redirects to the user' do
        patch :update, params: { id: user.id, user: valid_params }
        response.should redirect_to user
      end

      it 'has a 302 status code' do
        patch :update, params: { id: user.id, user: valid_params }
        expect(response.status).to eq(302)
      end
    end

    context 'invalid params sent' do
      let(:invalid_params) { { email: '' } }

      it 'does not update' do
        patch :update, params: { id: user.id, user: invalid_params }
        user.reload
        expect(user.email).to eq(email)
      end

      it 'redirects to the edit template' do
        patch :update, params: { id: user.id, user: invalid_params }
        expect(response).to render_template('edit')
      end

      it 'has a 200 status code' do
        patch :update, params: { id: user.id, user: invalid_params }
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the record' do
      delete :destroy, params: { id: user.id }
      expect { User.find(user.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
