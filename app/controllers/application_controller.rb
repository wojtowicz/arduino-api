# frozen_string_literal: true

class ApplicationController < ActionController::API
  after_action :delete_headers

  private

  def delete_headers
    response.headers.delete_if do |key|
      !%w[Content-Type Content-Length].include?(key)
    end
  end
end
