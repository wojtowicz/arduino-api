# frozen_string_literal: true

class ApplicationController < ActionController::Base
  after_action :delete_headers, if: :format_text?

  private

  def format_text?
    request.format.text?
  end

  def delete_headers
    response.headers.delete_if do |key|
      !%w[Content-Type Content-Length].include?(key)
    end
  end
end
