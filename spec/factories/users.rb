FactoryBot.define do
  factory :user do
    username { Faker::Name.middle_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8, mix_case: true, special_characters: true) }
  end
end
