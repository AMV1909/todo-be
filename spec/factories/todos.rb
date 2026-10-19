FactoryBot.define do
  factory :todo do
    user
    title { Faker::Lorem.sentence(word_count: 3).first(100) }
    description { Faker::Lorem.paragraph.first(500) }
    completed { false }
  end
end
