# README

## Friends

Friendships social network Rails application

## API Cals:

  > GET /members.json : returns system members list

  > GET /members/:id.json

  > POST /members.json

## Project Details:

* Environment

  > Rails Project with API support

  > Ruby 2.6.1

  > Rails 5.2.3

  > PostgreSQL

  > RSpec

* Configuration

  > copy `config/database.yml` from `config/database.yml.example`

  > copy `config/app_config.yml` from `config/app_config.yml.example`

  > copy `config/sidekiq.yml` from `config/sidekiq.yml.example`

* Database creation

  > run `rails db:create`

  > run `rails db:migrate`

  > run `rails db:seed`

## Tests

  > database migration `rails db:migrate RAILS_ENV=test`

  > run test `rspec`

## Sidekiq Worker

  > run `sidekiq`

## Production Deploy and Recommendations:

  > copy `config/database.yml` from `config/database.yml.example`

  > copy `config/app_config.yml` from `config/app_config.yml.example`

  > copy `config/sidekiq.yml` from `config/sidekiq.yml.example`

## ToDo

  > Add authentication and authorization

  > Add login, logout

  > Store the crawled HTML tags in document base database for better searching instead of storing in text field.

  > Add indexs for better seach performance.