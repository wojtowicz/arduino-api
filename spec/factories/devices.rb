# frozen_string_literal: true

# This will guess the User class
FactoryBot.define do
  factory :device do
    sequence :name do |n|
      "Device #{n}"
    end
    sequence :uuid do |n|
      "uuid#{n}"
    end
    lat { '50.06143' }
    lng { '19.93658' }
  end
end
