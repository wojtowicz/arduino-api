# frozen_string_literal: true

class Device < ApplicationRecord
  validates :uuid, uniqueness: true,
                   presence: true
  validates :name, presence: true

  attr_encrypted :airly_api_key,
                 key: Rails.application.credentials.fetch(:airly_key_base)

  def status
    return 'configuring' if sync_at.nil?

    online? ? 'online' : 'offline'
  end

  def pollution_configured?
    lat.present? && lng.present? && airly_api_key.present?
  end

  private

  def online?
    synced_at_in_minutes < 1
  end

  def synced_at_in_minutes
    return if sync_at.nil?

    ((Time.zone.now - sync_at) / 1.minutes).to_i
  end
end
