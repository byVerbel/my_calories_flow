# Ruby on Rails Bootcamp - Project 3

Log calories with your own user.

## Getting started

To get started with the app, first clone the repo and `cd` into the directory:

```
$ git clone https://github.com/byVerbel/project_3
$ cd project_3
```

Then install the needed packages (while skipping any Ruby gems needed only in production), remember to use the bundle version you have installed on your machine (I use 2.2.29):

```
$ gem install bundler -v 2.2.29
$ bundle _2.2.29_ config set --local without 'production'
$ bundle _2.2.29_ install
```

The Git architecture I will follow consists of a `main` branch that will only be updated after I've made considerable changes, with its corresponding tests, to the app. Most of my updates will go to the `production` branch. From this branch, I will create other ones depending on the `issue` I'll be currently working on.

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly. In this case, my tests are bollocs, so I recommend don't paying attention to them.

```
$ rails test
```

Run the server. I also use guard-livereload, it is included in the Gemfile, so run the next two commands in different terminals to take advantage of this:

```
$ bundle _2.2.29_ exec guard init livereload

$ rails server

$ bundle _2.2.29_ exec guard
```

## Deploying

To deploy this version of the app, you’ll need to create a new Heroku application, switch to the right branch, push up the source, run the migrations, and seed the database with sample users:

```
$ heroku create APPNAME
$ git checkout updating-users
$ git push heroku updating-users:main
$ heroku run rails db:migrate
$ heroku run rails db:seed
```

Visiting the URL returned by the original `heroku create` should now show you the sample app running in production. As with the local version, you can then register a new user or log in as you like.
