# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email            { Faker::Internet.email }
    password         "123456789"
    legacy_password  false
  end

  factory :legacy_user, class: 'User' do
    email               { Faker::Internet.email }
    password            "123456789"
    encrypted_password  Digest::MD5.hexdigest("123456789")
    legacy_password     true
  end
end
