require 'rails_helper'
require 'signin_helper'

RSpec.describe ArticlesController, type: :request do

    describe "when logged in" do
        it "access new articles creation path " do
            user = sign_in_user
            get new_article_path
            expect(response).to be_successful
        end
        it "access posted articles path " do
            article = create_dummy_article
            user = sign_in_user
            get "/articles/#{article.id}"
            expect(response).to be_successful
        end  
        it "edit posted articles " do
            article = create_dummy_article
            user = sign_in_user
            get "/articles/#{article.id}/edit"
            expect(response).to be_successful
        end  
        it "destroy posted articles " do
            article = create_dummy_article
            user = sign_in_user
            expect{delete "/articles/#{article.id}"}.to change(Article, :count).by(-1)
        end  
        # it "create new article " do
        #     article = Article.new()
        #     user = sign_in_user
        #     post "/articles"
        #     expect(response).to be_successful
        # end 
        it "update new article " do
            article = create_dummy_article
            user = sign_in_user
            patch "/articles/#{article.id}", params:{
                article: {
                    title: "updated title"
                }
            }
            expect(response).to redirect_to(article_path(article))
        end 
    end

    describe "when not logged in" do
        it "access articles path" do
            get articles_path
            expect(response).to be_successful
        end
        it " unable to access new articles creation path" do
            get new_article_path
            expect(response).to redirect_to(login_path)
        end
        it " access posted articles path " do
            article = create_dummy_article
            get "/articles/#{article.id}"
            expect(response).to be_successful
        end
        it "edit posted articles " do
            article = create_dummy_article
            get "/articles/#{article.id}/edit"
            user = sign_out_user
            expect(response).not_to be_successful
        end  
        it "destroy posted articles " do
            article = create_dummy_article
            user = sign_in_user
            delete "/articles/#{article.id}"
            user = sign_out_user
            expect(response).not_to be_successful
        end
        # it "create new article " do
        #     article = Article.new()
        #     user = sign_out_user
        #     post "/articles"
        #     expect(response).to be_successful
        # end   
        it "update new article " do
            user = sign_in_user
            article = create_dummy_article
            user = sign_out_user
            patch "/articles/#{article.id}", params:{
                article: {
                    title: "updated title"
                }
            }
            expect(response).to redirect_to(login_path)
        end 
    end
end