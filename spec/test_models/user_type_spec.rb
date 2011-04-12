require 'spec_helper'

describe UserType do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users)
      matcher.description.should == 'have a foreign key for users'
    end

    it 'should set failure_message_for_should message' do
      matcher = have_foreign_key_for(:user_types)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('user_types')} to include #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('user_types', 'user_types', :primary_key => 'id', :column => 'user_type_id', :name => 'user_types_user_type_id_fk')}"
    end

    it 'should set failure_message_for_should_not message' do
      matcher = have_foreign_key_for(:users)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('user_types')} to exclude #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('user_types', 'users', :primary_key => 'id', :column => 'user_id', :name => 'user_types_user_id_fk')}"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user) }
    it { should have_foreign_key_for(:users) }
  end
end
