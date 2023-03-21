def sign_in_user(admin=false) 
    post '/users', params: {
        user:{
            username: 'abcdef', 
            email: 'abc@example.com', 
            password: 'password'
            }
        }
    user = User.find_by(username: 'abcdef')
    user.toggle!(:admin) if admin
    return user
end
def sign_in_user1(admin=false) 
    post '/users', params: {
        user:{
            username: 'abcdefgh', 
            email: 'abc@example1.com', 
            password: 'password1'
            }
        }
    user = User.find_by(username: 'abcdefgh')
    user.toggle!(:admin) if admin
    return user
end
def create_dummy_article
    sign_in_user()
    post '/articles', params: {
        article:{
            title: "title123",
            description: "description123"
        }
    }
    return Article.find_by(title: "title123")
   
end

def sign_out_user
    sign_in_user()
    delete '/logout'
end

def create_dummy_category
    sign_in_user(true)
    post '/categories', params: {
        category:{
            name: "category123",
        }
    }
    return Category.find_by(name: "category123")
end