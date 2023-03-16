# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.sentence }
    article { build(:article) }
  end
end
