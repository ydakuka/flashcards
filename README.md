[![Build Status](https://travis-ci.org/ydakuka/flashcards.svg?branch=master)](https://travis-ci.org/ydakuka/flashcards)

[![Code Climate](https://codeclimate.com/github/ydakuka/flashcards/badges/gpa.svg)](https://codeclimate.com/github/ydakuka/flashcards)

[![Test Coverage](https://codeclimate.com/github/ydakuka/flashcards/badges/coverage.svg)](https://codeclimate.com/github/ydakuka/flashcards/coverage)

To start this application do following steps:
* `bundle`
* Add `config/application.yml` with

  ```
  db_user: <Your database user>
  db_password: <Your database user password>
  ```
* `rake db:create` `rake db:migrate`
* `rails s`
