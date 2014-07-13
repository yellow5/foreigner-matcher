require 'spec_helper'

describe UserType do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users)
      matcher.description.should == 'have a foreign key for users'
    end

    it 'should set failure_message message' do
      stub_fkd_to_s_with('expected fk')
      matcher = have_foreign_key_for(:user_types)
      matcher.matches?(subject)
      matcher.failure_message.should == "expected #{foreign_keys_for('user_types')} to include expected fk"
    end

    it 'should set failure_message_when_negated message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher = have_foreign_key_for(:users)
      matcher.matches?(subject)
      matcher.failure_message_when_negated.should == "expected #{foreign_keys_for('user_types')} to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    before do
      @options = postgresql_db?  ? { :dependent => :restrict } : {}
    end

    it { should have_foreign_key_for(:user, @options) }
    it { should have_foreign_key_for(:users, @options) }
  end
end
