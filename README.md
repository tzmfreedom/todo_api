[![Build Status](https://travis-ci.org/tzmfreedom/todo_api.svg?branch=master)](https://travis-ci.org/tzmfreedom/todo_api)

# API Server for Todo APP

- Language: Ruby 2.2.4
- Framework:
    - Web: [Grape](https://github.com/ruby-grape/grape)
    - Model: [ActiveRecord](https://github.com/rails/rails/tree/master/activerecord)
- Database: PostgreSQL(Heroku Postgres)
- Tools:
  - [Ridgepole](https://github.com/winebarrel/ridgepole)

## API Specification

|Action      |HTTP Method |URI          |
|:-----------|:-----------|:------------|
|Search Todo |GET         |/api/todo(.json)|
|Create Todo |POST        |/api/todo(.json)|
|Update Todo |PUT         |/api/todo/:id(.json)|
|Delete Todo |DELETE      |/api/todo/:id(.json)|

### Example

Search Todo
```bash
$ curl -i -X GET \
 "${URI_BASE}/api/todos"
```

Create Todo
```bash
$ curl -i -X POST \
   -H "Content-Type:application/json" \
   -d \
'{"title":"This is title","description":"This is description"}' \
 "${URI_BASE}/api/todos"
```

Update Todo
```bash
$ curl -i -X PUT \
   -H "Content-Type:application/json" \
   -d \
'{"title":"This is modified title"}' \
 "${URI_BASE}/api/todos/${TODO_ID}"
```

Delete Todo
```bash
$ curl -i -X DELETE \
 "${URI_BASE}/api/todos/${TODO_ID}"
```

## Installation

```bash
$ bundle install
$ bundle exec ridgepole -c config/database.yml --apply
```

## Run on local

```bash
$ bundle exec rackup config.ru
```

## Run on Heroku

```bash
$ heroku login
$ heroku apps:create {APP_NAME}
$ heroku git:remote -a {APP_NAME}
$ git push heroku master
$ heroku run 'bundle exec ridgepole -c \
config/database.yml -E production --apply' --app {APP_NAME}
```

## Test

```bash
$ bundle exec ridgepole -c config/database.yml --apply -E test
$ bundle exec rake
```
