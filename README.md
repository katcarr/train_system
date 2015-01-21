Train Station
==========

Creates a web app using Ruby to add a list and allow tasks to be added to a list
using a SQL database.

Database Setup
--------------

```sh
$ psql
$ CREATE DATABASE train_system;
$ \c train_system;
$ CREATE TABLE lines (id serial PRIMARY KEY, name varchar);
$ CREATE TABLE station (id serial PRIMARY KEY, name varchar);
$ CREATE TABLE connections (id serial PRIMARY KEY, station_id int, line_id int);
```
App Setup
----------

Assuming you have ruby installed. In the terminal:
```sh
$ gem install bundler
$ bundle
$ ruby app.rb
```

Go to http://localhost:4567 in your browser

Tests
-----

In psql

```sh
$ CREATE DATABASE train_system_test WITH TEMPLATE train_system
```

Testing the ruby methods can be done via rspec.

```sh
$ gem install rspec
$ rspec
```
Motivation
---------

This app was created to practice interacting with SQL databases using PostgreSQL and the PG gem.

License
-------

MIT License, copyright 2015. Created by Kathryn Carr & Ron Park.
