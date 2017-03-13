[![Build Status](https://travis-ci.org/ydakuka/flashcards.svg?branch=master)](https://travis-ci.org/ydakuka/flashcards)

[![Code Climate](https://codeclimate.com/repos/551d5933695680514c00019c/badges/20539730e3e119e4d337/gpa.svg)](https://codeclimate.com/repos/551d5933695680514c00019c/feed)

To start this application do following steps:
* `bundle`
* Add `config/application.yml` with

  ```
  db_user: <Your database user>
  db_password: <Your database user password>
  ```
* `rake db:create` `rake db:migrate`
* `rails s`
