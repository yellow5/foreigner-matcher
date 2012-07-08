# foreigner-matcher

[![Build Status](https://secure.travis-ci.org/yellow5/foreigner-matcher.png?branch=master)](http://travis-ci.org/yellow5/foreigner-matcher)

RSpec matcher for the [Foreigner gem](https://github.com/matthuhiggins/foreigner), inspired by [Remarkable](https://github.com/remarkable/remarkable) ActiveRecord matchers.

## Version Information

Note that the matcher is exactly the same between 0.1.1 and 0.2.0; all that changes is the Foreigner dependency. Why, you ask? Foreigner >= 1.0.0 is Rails 3.x only!

**Rails 3.x**

Foreigner >= 1.0.0 use foreigner-matcher ~> 0.2.0

Foreigner ~> 0.9 use foreigner-matcher ~> 0.1.1

**Rails 2.3**

Use foreigner-matcher ~> 0.1.1

## Installation

*Please check the Version Information for the appropriate version!*

For installation with bundler, add the following to the approrpriate group in your Gemfile:

    gem "foreigner-matcher", "~> 0.2.0", :require => nil

For installation without bundler in Rails 2.3, add the following to your config/environments/test.rb:

    config.gem "foreigner-matcher", "~> 0.1.1", :require => nil

To install the gem the old fashioned way:

    gem install foreigner-matcher

In spec\_helper.rb:

    require 'foreigner-matcher'

Note that the entry in spec\_helper.rb must follow any <tt>require</tt> for RSpec libraries.

## Usage

The matcher can be used in RSpec to ensure an ActiveRecord model has the desired foreign key. The minimum argument is the table name that the subject model should have a foreign key to.

For example. Given these two models:

    class User < ActiveRecord::Base
      has_many user_logins
    end

    class UserLogin < ActiveRecord::Base
      belongs_to user
    end

And given this migration for the foreign key:

    class ChangeUserIdToForeignKeyOnUserLogins < ActiveRecord::Migration
      def self.up
        add_foreign_key :user_logins, :users
      end

      def self.down
        remove_foreign_key :user_logins, :users
      end
    end

The spec would look like this:

    describe UserLogin do
      it { should have_foreign_key_for(:users) }
    end

In addition to the table name, you can include any options that <tt>add\_foreign\_key</tt> (see [Foreigner](https://github.com/matthuhiggins/foreigner)) accepts. Some more examples using the same models:

    it { should have_foreign_key_for(:users, :dependent => :delete) }
    it { should have_foreign_key_for(:users, :column => "unique_user_id", :name => "user_logins_unique_user_id_fk") }
    it { should_not have_foreign_key_for(:users, :dependent => :nullify) }

**A Note on Table Names**

These examples will also work passing <tt>:user</tt> as the table name. Why? The example has a <tt>belongs\_to</tt> relationship, and my feeling is that it reads better to say &quot;it should have foreign key for user&quot;. This is just my taste; use what makes sense to you!

## My Testing Environment

The project is tested on [Travis-CI](https://github.com/travis-ci/travis-ci). The rubies and databases that the matcher is regularly verified with can be seen in [.travis.yml](https://github.com/yellow5/foreigner-matcher/blob/master/.travis.yml)

The current gems that are tested:

* ActiveRecord ~> 3.2.0, Rspec ~> 2.11.0, Foreigner >= 1.00
* ActiveRecord ~> 3.1.0, Rspec ~> 2.11.0, Foreigner >= 1.00
* ActiveRecord ~> 3.0.0, Rspec ~> 2.11.0, Foreigner >= 1.00

## Copyright

Copyright (c) 2011-2012 Cameron Dykes. See LICENSE.txt for further details.
