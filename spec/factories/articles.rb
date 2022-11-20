require "faker"

FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.characters(number: 10) }
  end
end
