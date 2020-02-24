# frozen_string_literal: true

class ApiResponder < ActionController::Responder
  private

  def resource_errors
    { errors: error_details }
  end

  def error_details
    extended_details = {}
    resource.errors.details.each do |key, details|
      extended_details[key] = details_with_message(key, details)
    end
  end

  def details_with_message(key, details)
    details.each_with_index.map do |detail, index|
      detail[:message] = resource.errors.messages[key][index]
      detail
    end
  end
end
