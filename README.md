# This demo is obsolete, take a look at [Apipie-demo](https://github.com/iNecas/apipie-demo) instead

# Restapi Usage Example Application

This is a sample Rails application demonstrating the features of the
[Restapi](http://github.com/Pajk/rails-restapi) gem.

You can either follow the instructions below or `git log
origin/result` to see the progress.

You can see the final state of the app after the tutorial in the
`result` branch.

For more information see the documentation for the Restapi gem.

### Getting started

The idea behind this sample app called "TwitterScheduler" is a service
that allows you to schedule tweets for users in future. It contains
two resources with CRUD operations: users and tweets (that are nested
inside the users).

To run this demo, you need to run Ruby 1.9.2 or higher (although the
Restapi gem is compatible with 1.8.7).

To get the app up and running run this commands:

    bundle install
    rake db:setup
    rails server        

To test that it works we can use `curl` to see it working:

    curl -H "Content-Type: application/json" -X POST\
         -d '{"user":{"name":"admin"}}'\
          http://localhost:3000/users

    curl -H "Content-Type: application/json" -X POST\
         -d '{"tweet":{"text":"Hurray, I've survived",
                       "scheduled_at":"2012-12-22T01:00"}}'\
          http://localhost:3000/users/1/tweets

### Api Doc In 1 Minute

Setting up the Restapi to be used in our app is simple. We
add the dependency into our `Gemfile` and run `bundle install` again:

```ruby
gem 'restapi'
```

Then set up the basic configuration in `config/initializers/restapi.rb`:

```ruby
Restapi.configure do |config|
  config.app_name = "TwitterScheduler"
  config.app_info = "Write now, tweet tomorrow"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
end
```

and add the routes into your `routes.rb` file, so that it looks like this:

```ruby
Demo::Application.routes.draw do
  restapi

  resources :users, except: :edit do
    resources :tweets, except: :edit
  end
end
```

Although we have no documentation yet, `routes.rb` and our tests
already contain very interesting information. All we need is to put it
into one place. And Restapi provides a way how to do it:

    RESTAPI_RECORD=all rake test:functionals

CONGRATULATION!!! You've just created the fist cut documentation of
your API.

When we open the `TweetsController` we can see, that out of sudden
there is a description of every action. And more then that: the tool
also tried to recognize the type of params if possible (such as the
`sent` param is `:bool`).

To see the output, just open `http://localhost:3000/restapi`.

You might notice that besides the params descriptions there are also
examples available in the documentation, although they are not in the
source code. Restapi uses separate file `doc/restapi_examples.yml`.
That make the code more readable (the examples can really be
disturbing) and also makes it easier to regenerate the examples again
and again.

### CLI and bindings

With proper API description, it's not so hard to get bindings and CLI
client for free. All you need is running:

    rake restapi:client

New directory `client` appears with the bindings and CLI ready to be
used. Let's try it:

    cd client
    bundle install
    bin/twitterscheduler-client user index
    bin/twitterscheduler-client tweet help
    bin/twitterscheduler-client tweet help create
    bin/twitterscheduler-client tweet create --user-id 1\
      --text "I've found a really nice API tool yesterday: the Restapi gem"\
      --scheduled-at "2012-07-15T12:00"

You can also use the generated code to access the service from another
ruby project using the Ruby bindings:

```ruby
irb -I lib
require 'twitterscheduler_client'
user = TwitterschedulerClient::Resources::User.new(:base_url => 'http://localhost:3000')
user.index
```

### Validations

Without automation, one can't be sure that the documentation is still
up-to-date. That's the reason why the Restapi gem also provides
validation features.

Let's try to proved invalid value for some param:

    bin/twitterscheduler-client tweet create --user-id 1\
      --text "I've found a really nice API tool yesterday: the Restapi gem"\
      --scheduled-at "2012-07-15T12:00"\
      --sent "2012-07-15T13:00"

Since we defined the `sent` param to be a boolean, we'll get an error
message describing this problem. The same situation might appear if
you change your code (and your tests) but forget to change the doc.
With validations turned on, you might avoid this inconsistency.

You can also decide not to use validations at all, by setting

    config.validate = false

### Time To Share

You might decide to make your documentation available without need to
run the service itself. All you need is to run:

     rake restapi:static

You can find various versions of the static HTML in `doc/apidoc*`
files (structured, one-page, plain html).

### Conclusion

We've just went through the basic scenarios that are covered by the
Restapi gem. I hope you've liked it. For more information see the
documentation for the gem. There are other features you might be
interested in, such as:

  * API for your doc
  * different markup languages support
  * cache in production
  * and others

The tool will be just as good as the users decide it to be. If you
find a bug or you have a suggestion for improvement, please file an
issue in the Github tracker. Patches welcome.
