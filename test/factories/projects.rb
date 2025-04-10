# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    title { Faker::App.name }
    status { "draft" }
    association :user
  end
end
