## Requirements:
- Postgres 11
- Redis 4.0.9
- Ruby 2.6.3
- Node 13.2.0
- Yarn 1.21.1

## Initial Setup
Run the following:
```
> gem install bundler
> gem install foreman
> bundle install
> yarn install
> bin/rails db:setup
```

## Execute tests
Run the following:
```
> bundle exec rspec
> yarn test
```

## Lint and analyze code
Run the following:
```
> bundle exec rubocop
> bundle exec brakeman
> bundle audit check --update
> yarn eslint -c ./.eslintrc.js ./app/javascript
> bundle exec erblint --config .erb-lint.yml --lint-all
> yarn stylelint app/javascript/css/**/*.css
```

## Start Application
Run the following:
```
> foreman start
```

Application should be available at `localhost:5000`.
Sidekiq console should be available at `localhost:5000/sidekiq`.
