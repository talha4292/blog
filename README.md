##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.3]
- Rails [5.2.8]
- PostgreSQL [14.5]

##### 1. Check out the repository

```bash
git clone git@github.com:talha4292/blog.git
```

##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000
