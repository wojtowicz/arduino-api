# frozen_string_literal: true

module Helpers
  def fixture_json_data(file_name)
    JSON.parse(file_fixture(file_name).read).to_json
  end
end
