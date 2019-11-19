# frozen_string_literal: true

namespace :brakeman do
  desc 'Run Brakeman'
  task :run do
    sh 'brakeman'
  end
end
