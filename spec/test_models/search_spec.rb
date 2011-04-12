require 'spec_helper'

describe Search do
  describe 'messages' do
    it "should contain a description" do
      matcher = have_foreign_key_for(:users, :name => "user_search_special_fk", :dependent => :delete)
      matcher.description.should == "have a foreign key for users with {:dependent=>:delete, :name=>\"user_search_special_fk\"}"
    end

    it "should set failure_message_for_should message" do
      matcher = have_foreign_key_for(:searches)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('searches')} to include #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('searches', 'searches', :primary_key => 'id', :column => 'search_id', :name => 'searches_search_id_fk')}"
    end

    it "should set failure_message_for_should_not message" do
      matcher = have_foreign_key_for(:users, :name => "user_search_special_fk", :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('searches')} to exclude #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('searches', 'users', :primary_key => 'id', :column => 'user_id', :name => 'user_search_special_fk', :dependent => :delete)}"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :name => "user_search_special_fk", :dependent => :delete) }
    it { should have_foreign_key_for(:users, :name => "user_search_special_fk", :dependent => :delete) }
  end
end
