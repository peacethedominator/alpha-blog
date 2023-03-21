require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe "create action" do
    let!(:user) { User.create(username: 'user123', email: 'test@example.com', password: 'password') }
    context 'with valid credentials' do
      it 'sets user id  in session' do
        post login_path, params: {
          session: {
            email: 'test@example.com', 
            password: 'password'
          }
        }
        expect(session[:user_id]).to eq(user.id)
      end
      it 'redirects to the user profile page' do
        post login_path, params: { 
          session: { 
            email: 'test@example.com', 
            password: 'password' 
            } 
          }
        expect(response).to redirect_to(user_path(user))
      end
      it 'sets a success flash message' do
        post login_path, params: { 
          session: { 
            email: 'test@example.com', 
            password: 'password' 
            } 
          }
        expect(flash[:notice]).to eq('Logged in successfully')
      end
    end
    context 'with invalid credentials' do
      it 'renders new template on login' do
        post login_path, params: {
          session: {
            email: 'test@example.com', 
            password: 'wrongpassword'
          }
        }
        expect(response).to render_template(:new)
      end
      it 'sets an error flash message' do
        post login_path, params: { 
          session: { 
            email: 'test@example.com', 
            password: 'wrongpassword' 
            } 
          }
        expect(flash[:alert]).to eq('There was something wrong with your credentials')
      end
    end
  end
  describe "#new action" do
    it 'access login path' do
      get login_path
      expect(response).to render_template(:new)
    end
  end
  describe "#destroy action" do
    before{post login_path, params: {
      session: {
        email: 'test@example.com', 
        password: 'password'
      }
    }
    session[:user_id] = user.id}
    let!(:user) { User.create(username: 'user123', email: 'test@example.com', password: 'password') }
    it 'removes user id from session ' do
      delete logout_path
      expect(session[:user_id]).to be_nil
    end
    it 'sets success flash message' do
      delete logout_path
      expect(flash[:notice]).to eq('Logged out')
    end
    it 'redirects to root path' do
      delete logout_path
      expect(response).to redirect_to(root_path)
    end
  end
end