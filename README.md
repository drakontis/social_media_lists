## Overview
This is a simple application that displays posts from the social media of different groups of people. 
The groups could be created dynamically by the user, or could be tables of people in the database.
You can apply the following filters in your search:
* a list of the social media where the posts were written
* a date range
* a list of groups

Some improvements in the UI could be done in the future.

This application is not scrapping the social media (yet). 
Currently, it makes the assumption that an external application/service scrapes the social media and provides this application with data.

## Architecture
The application is divided in three modules. The main ones are the *lists* module, that encapsulates the logic about the lists and the *social networks* module, that encapsulates the logic about the social networks.
In addition, the module *forms* includes the class *search* that is responsible for the search logic.

I tried to create a common interface between the two types of lists (custom and from database), 
which is why in the *federal_legislators* table I created an association with the *person* class. 
I also added the methods *first_name* and *last_name* in order not to break the current interface of the class *federal_legislators*.


## Usage
To run the application you should have the following software installed:
* Postgresql RDBMS
  * [Installation Instructions](http://postgresguide.com/setup/install.html)
* RVM (Ruby Version Manager)
  * [Installation Instructions](https://rvm.io/rvm/install)
* Ruby v2.2.8
  * To Install ruby just type in a console:

```rvm install ruby-2.2.8```

When the required software is installed, visit the project’s root folder (if you are already there just type cd .) and type:

```rvm current```

You should see something like this:

```ruby-2.2.8@social_media_lists```

Then you need to install the bundler gem. In the project’s root folder type:

```gem install bundler```

Now you are ready to install all the external libraries (gems). To do this in the project’s root folder type:

```bundle install```

(This could take a while.)

Now let’s configure the database.
* Rename the config/database.yml.sample to config/database.yml and in the development section set the username and password for the Postgresql user.
* Create the database and run the schema migrations by typing the two following commands:

```
rake db:create
rake db:migrate
```

If you want to recreate the database run the following commands:

```
rake db:drop
rake db:create
rake db:migrate
```

There are some seeds that provide the application with data. To run the seeds, type in the project's root folder:
```
rake db:seed
```

This command will populate the database with the following data:
* 100 Custom lists
* 2 Social networks
* 5000 People
* 500000 Posts

The previous command takes a lot of time to complete. You can shorten the procedure, decreasing the amount of created data, by editing the following files:
* db/seeds/seed_custom_lists.rb
* db/seeds/seed_people.rb
* db/seeds/seed_social_networks.rb
* db/seeds/seed_posts.rb

Now you are ready to start your server. In the project’s root folder type:

```
rails s
```

You should see that the server is running.
Now you are ready to search for posts.

## Tests
The application is fully unit tested and also includes some functional tests, to ensure that the integration between the application’s components is working.
To run the whole test suite from the project’s root folder just type:

```
rspec spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drakontis/social_media_lists.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
