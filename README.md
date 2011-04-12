# foreigner-matcher

RSpec matcher for the [Foreigner gem](https://github.com/matthuhiggins/foreigner).

## Installation

    gem install foreigner-matcher

## Usage

The matcher can be used in RSpec to ensure an ActiveRecord model has the desired foreign key. The minimum argument is the table name that the subject model should have a foreign key to.

For example. Given these two models:

    class User < ActiveRecord::Base
      has_many user_logins
    end

    class UserLogin < ActiveRecord::Base
      belongs_to user
    end

The spec would look like this:

    describe UserLogin do
      it { should have_foreign_key_for(:users) }
    end

In addition to the table name, you can include any options that add_foreign_key (see [Foreigner](https://github.com/matthuhiggins/foreigner)) accepts. Some more examples using the same models:

    it { should have_foreign_key_for(:users, :dependent => :delete) }
    it { should have_foreign_key_for(:users, :column => "unique_user_id", :name => "user_logins_unique_user_id_fk") }
    it { should_not have_foreign_key_for(:users, :dependent => :nullify) }

**A Note on Table Names**

These examples will also work passing <tt>:user</tt> as the table name. Why? The example has a <tt>belongs_to</tt> relationship, and my feeling is that it reads better to say "it should have foreign key for user". This is just my taste; use what makes sense to you!

## Copyright

Copyright (c) 2011 Cameron Dykes. See LICENSE.txt for further details.
