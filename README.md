# README

* Prerequisites
The setups steps expect following tools installed on the system.

Git
Ruby 3.2.0
Rails 7.0.8
PostgreSQL

* Setup Instructions

  1. Check out the repository
  git clone git@github.com:organization/project-name.git

  2. Install dependencies:
    bundle install

  3. Set up the database:
    rails db:create
    rails db:migrate

  4. Seed the database with sample data:
    rails db:seed

* Database Configuration

  This project uses PostgreSQL as its database. Make sure you have PostgreSQL installed on your system. You can configure the database connection in config/database.yml if needed.
  
* Running the Application
  rails server

* Testing
    rspec