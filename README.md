# <!--PROJECT NAME HERE-->

<!--PROJECT DESCRIPTION HERE-->

### Prerequisites

Web browser with ES6 compatibility
Examples: Chrome, Safari

Ruby <!--VERSION HERE-->
Bundler

### Installing

#### To Build SQL Database

create database library;
create table books (id uuid primary key, title varchar, author varchar);
create table patrons (id uuid primary key, name varchar);
create table records (id uuid primary key, patron_id uuid, book_id uuid, date_out date, date_in date, date_renewed date);
create database library_test with template library;

Installation is quick and easy! First you can open this link <!--HEROKU LINK HERE--> to see the webpage in action live online. Or you can clone this repository to your machine, navigate to the file path in your terminal, and run 'app.rb' by typing '$ruby app.rb'. If you chose to clone the repository, after you run 'app.rb' you will need to copy the localhost path into your web browser. The standard localhost for Sinatra is port 4567

## Built With

* Ruby
* Sinatra
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/

## Specifications

| behavior |  input   |  output  |
|----------|:--------:|:--------:|
<!--SPECS GO HERE-->

## Authors

* <!--YOUR NAME HERE-->

## License

Copyright © 2017 <!--YOUR NAME HERE-->
