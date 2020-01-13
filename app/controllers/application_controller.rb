# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  after_action :delete_headers

  private

  def delete_headers
    response.headers.delete_if do |key|
      !%w[Content-Type Content-Length].include?(key)
    end
  end
end
