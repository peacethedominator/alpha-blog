FactoryBot.define do
    factory :article do
      title { "Example Article" }
      description { "This is an example article." }
      association :category, factory: :category
    end
  end
  