require 'rails_helper'

describe Article do
    before(:each) do
        @article = Article.new     
        @user=User.new   
    end
    context 'before publication' do
        it 'must have a user' do
            @article.user=@user
            @article.title = "title123"
            @article.description=" description now one"
            expect(@article.save!).to be_truthy
        end
    end
    it 'must have a title' do
        @article.description=" description now one"
        @article.user=@user
        expect(@article.title).to be_falsey
    end
    it 'must have a description' do
        article = Article.new
        article.title = "title123"
        expect(@article.description).to be_falsey
    end
    it 'title should be of min 6 char' do
        @article.description=" description now one"
        @article.user=@user
        @article.title = "title1"
        expect(@article.title.length).to be >= 6
    end
end
