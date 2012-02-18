require 'spec_helper'

describe Comment do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users, :dependent => :delete)
      matcher.description.should == 'have a foreign key for users with {:dependent=>:delete}'
    end

    it 'should set failure_message_for_should message' do
      stub_fkd_to_s_with('expected fk')
      matcher = have_foreign_key_for(:comments)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{foreign_keys_for('comments')} to include expected fk"
    end

    it 'should set failure_message_for_should_not message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher = have_foreign_key_for(:users, :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{foreign_keys_for('comments')} to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :dependent => :delete) }
    it { should have_foreign_key_for(:users, :dependent => :delete) }
  end
end
