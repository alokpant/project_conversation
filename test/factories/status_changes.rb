# frozen_string_literal: true

FactoryBot.define do
  factory :status_change do
    previous_status { "draft" }
    new_status { "active" }
    association :user
    association :project
  end
end
