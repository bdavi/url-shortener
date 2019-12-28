## Requirements:
- Postgres 11
- Redis 4.0.9
- Ruby 2.6.3
- Node 13.2.0
- Yarn 1.21.1
- Heroku CLI
- Bundler gem

## Setup
Run the following:
```
> bin/setup
```

## Build
Run the following:
```
> bin/local-build
```

## Start Application
Run the following:
```
> heroku local
```

Application is available at `localhost:5000`.

Sidekiq console is available at `localhost:5000/sidekiq`.
