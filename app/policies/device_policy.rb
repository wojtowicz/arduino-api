# frozen_string_literal: true

class DevicePolicy < ApplicationPolicy
  def measurements?
    record.pollution_configured?
  end
end
