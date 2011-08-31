require 'spec_helper'

describe Comment do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users, :dependent => :delete)
      matcher.description.should == 'have a foreign key for users with {:dependent=>:delete}'
    end

    it 'should set failure_message_for_should message' do
      matcher     = have_foreign_key_for(:comments)
      expected_fk = Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('comments', 'comments', :primary_key => 'id', :column => 'comment_id', :name => 'comments_comment_id_fk')
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('comments')} to include #{expected_fk}"
    end

    it 'should set failure_message_for_should_not message' do
      matcher     = have_foreign_key_for(:users, :dependent => :delete)
      expected_fk = Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('comments', 'users', :primary_key => 'id', :column => 'user_id', :name => 'comments_user_id_fk', :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('comments')} to exclude #{expected_fk}"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :dependent => :delete) }
    it { should have_foreign_key_for(:users, :dependent => :delete) }
  end
end
