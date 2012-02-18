require 'spec_helper'

describe Search do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users, :name => 'user_search_special_fk', :dependent => :delete)
      matcher.description.should == 'have a foreign key for users with {:dependent=>:delete, :name=>"user_search_special_fk"}'
    end

    it 'should set failure_message_for_should message' do
      stub_fkd_to_s_with('expected fk')
      matcher = have_foreign_key_for(:searches)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('searches')} to include expected fk"
    end

    it 'should set failure_message_for_should_not message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher = have_foreign_key_for(:users, :name => 'user_search_special_fk', :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('searches')} to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :name => 'user_search_special_fk', :dependent => :delete) }
    it { should have_foreign_key_for(:users, :name => 'user_search_special_fk', :dependent => :delete) }
  end
end
