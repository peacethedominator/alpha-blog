require 'rails_helper'
require 'signin_helper'
RSpec.describe UsersController, type: :request do
    describe 'GET http status' do
        it 'check login route to be accessible' do
            get "/login"
            expect(response).to have_http_status(200) 
        end
    end
    describe '#new action' do
        it 'assigns new user' do
            get signup_path
            expect(assigns(:user)).to be_a_new(User)
        end
        it 'renders new template' do
            get signup_path
            expect(response).to render_template(:new)
        end
    end
    describe '#index action' do
        it 'renders index template' do
            get users_path
            expect(response).to render_template(:index)
        end
    end
    describe '#show action' do
        it 'renders show template' do
            user = sign_in_user
            get "/users/#{user.id}"
            expect(response).to render_template(:show)
        end
        it 'assigns user' do
            user = sign_in_user
            get "/users/#{user.id}"
            expect(assigns(:user)).to eq(user)
        end
    end
    describe '#create action' do
        it ' creates new user' do
            expect{ post users_path, params: { 
                user:{
                    username: "user123",
                    email: "user@example.com",
                    password: "password"
                }
            }}.to change(User, :count).by(1)
        end
    end
    describe '#edit' do
        let(:user) { User.create(username: 'johndoe', email: 'johndoe@example.com', password: 'password') }
        let(:other_user) { User.create(username: 'janedoe', email: 'janedoe@example.com', password: 'password') }
        context 'when logged in' do
            # before do
            #     session[:user_id] = user.id
            #     get "/users/#{user.id}/edit"
            # end
            it 'render edit template' do
                user= sign_in_user
                get "/users/#{user.id}/edit" 
                expect(response).to render_template(:edit)
            end
        end
        context 'when not logged in' do
            before { get "/users/#{user.id}/edit"}
            it 'redirects to login page' do
                expect(response).to redirect_to(login_path)
            end
            it 'sets a flash message' do
                expect(flash[:alert]).to eq('You must be logged in to perform that action.')
            end
        end
    end
    describe '#destroy action' do
        context 'when not logged in as admin' do
            it 'redirects to login page' do
                user = sign_in_user
                delete "/users/#{user.id}"
                expect(response).to redirect_to(articles_path)
            end
            it 'deletes user if same user' do
                user = sign_in_user
                expect {delete "/users/#{user.id}"}.to change(User, :count)
            end
            # it 'does not deletes user if another user' do
            #     user = sign_in_user
            #     user1 = sign_in_user1
            #     session[:user_id] = user1.id
            #     expect {delete "/users/#{user.id}"}.to_not change(User, :count)
            # end
        end
    end
end
