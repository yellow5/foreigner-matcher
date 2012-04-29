require 'spec_helper'

describe DefaultOption do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users)
      matcher.description.should == 'have a foreign key for users'
    end

    it 'should set failure_message_for_should message' do
      stub_fkd_to_s_with('expected fk')
      matcher = have_foreign_key_for(:default_options)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{foreign_keys_for('default_options')} to include expected fk"
    end

    it 'should set failure_message_for_should_not message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher = have_foreign_key_for(:users)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{foreign_keys_for('default_options')} to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    class DefaultOptionTester
      include ConnectionHelpers
    end

    it { should have_foreign_key_for(:user)  }
    it { should have_foreign_key_for(:users) }

    if DefaultOptionTester.new.postgresql_db?
      context 'with :dependent => nil option' do
        it { should have_foreign_key_for(:user,  :dependent => nil) }
        it { should have_foreign_key_for(:users, :dependent => nil) }
      end
    end
  end
end
