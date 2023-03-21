FactoryBot.define do
    factory :user do
      email { "test@example.com" }
      password { "password" }
      username { "user123"}
    end
  end
  