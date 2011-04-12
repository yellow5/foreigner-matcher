require 'spec_helper'

describe UserLogin do
  describe 'messages' do
    it "should contain a description" do
      matcher = have_foreign_key_for(:users, :dependent => :nullify)
      matcher.description.should == "have a foreign key for users with {:dependent=>:nullify}"
    end

    it "should set failure_message_for_should message" do
      matcher = have_foreign_key_for(:user_logins)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('user_logins')} to include #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('user_logins', 'user_logins', :primary_key => 'id', :column => 'user_login_id', :name => 'user_logins_user_login_id_fk')}"
    end

    it "should set failure_message_for_should_not message" do
      matcher = have_foreign_key_for(:users, :dependent => :nullify)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('user_logins')} to exclude #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('user_logins', 'users', :primary_key => 'id', :column => 'user_id', :name => 'user_logins_user_id_fk', :dependent => :nullify)}"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :dependent => :nullify) }
  end
end
