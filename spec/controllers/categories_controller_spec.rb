require 'rails_helper'
require 'signin_helper'

RSpec.describe CategoriesController, type: :request do
describe "when logged in as admin" do
  before(:each) do
    user = sign_in_user(true)
    @category=Category.create(name: "testtt")
  end
  it "access categories path " do
    get categories_path
    expect(response).to be_successful
  end
  it "access new categories creation path " do
    get new_category_path
    expect(response).to be_successful
  end
  it "create new category" do
    expect{post '/categories', params:{
      category:{
        name:"travel"
      }
    }
  }.to change(Category, :count).by(1)
  end

  it "edit categories path " do
    get "/categories/#{@category.id}/edit"
    expect(response).to be_successful
  end  
  it "update a category " do
    patch "/categories/#{@category.id}", params:{
      category: {
        name: "category12345"
      }
    }
    follow_redirect!
    expect(response).to be_successful
  end
end
describe "when logged in as common user" do
  before(:each) do
    user = sign_in_user
  end
  it "access categories path " do
    get categories_path
    expect(response).to be_successful
  end
  it "unable to access new categories creation path " do
    get new_category_path
    expect(response).not_to be_successful
  end
  it "unable to edit categories path " do
    category = create_dummy_category
    user = sign_in_user1
    get "/categories/#{category.id}/edit"
    expect(response).not_to be_successful
  end
  it 'displays categories' do
    category = create_dummy_category
    user = sign_in_user(false)
    get "/categories/#{category.id}"
    expect(response). to be_successful
  end
  it "unable to update a category " do
    category = create_dummy_category
    patch "/categories/#{category.id}", params:{
      category: {
        name: "category123"
      }
    }
    expect(response).not_to be_successful
  end
end
end

