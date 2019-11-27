# frozen_string_literal: true

class Device < ApplicationRecord
  validates :uuid, uniqueness: true,
                   presence: true

  attr_encrypted :airly_api_key,
                 key: Rails.application.credentials.fetch(:airly_key_base)
end
