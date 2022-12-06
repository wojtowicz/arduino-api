# require "application_responder"

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  self.responder = ApiResponder
  respond_to :json

  skip_before_action :verify_authenticity_token
  include Pundit::Authorization
  after_action :delete_headers, if: :format_text?

  # TODO: Remove this line when add devise gem
  def current_user; end

  rescue_from Pundit::NotAuthorizedError, with: :not_authorized_error

  private

  def not_authorized_error(exception)
    policy_name = exception.policy.class.to_s.underscore
    error_code = "#{policy_name}.#{exception.query}"
    message = t error_code, scope: 'pundit', default: :default
    render json: { error: { code: error_code, message: message } },
           status: :forbidden
  end

  def format_text?
    request.format.text?
  end

  def delete_headers
    response.headers.delete_if do |key|
      !%w[Content-Type Content-Length].include?(key)
    end
  end
end
