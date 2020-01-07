# frozen_string_literal: true

def system!(*args)
  system(*args) || abort("\n== Command #{args} failed ==")
end

desc 'Build/Test App'
task build: :environment do
  system! 'bundle exec rspec'
  system! 'yarn test'
  system! 'bundle exec rubocop'
  system! 'bundle exec brakeman --no-summary'
  system! 'bundle audit check --update'
  system! 'yarn eslint -c ./.eslintrc.js ./app/javascript'
  system! 'bundle exec erblint --config .erb-lint.yml --lint-all'
  system! 'yarn stylelint app/javascript/css/**/*.css'
  system! 'bundle exec rubycritic'
  system! 'bundle exec fasterer'
  system! 'bundle exec rails_best_practices .'
end
