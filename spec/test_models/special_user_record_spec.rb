require 'spec_helper'

describe SpecialUserRecord do
  describe 'messages' do
    it 'should contain a description' do
      matcher = have_foreign_key_for(:users, :column => 'special_user_id', :name => 'special_user_records_special_user_id_fk', :dependent => :delete)
      matcher.description.should == 'have a foreign key for users with {:column=>"special_user_id", :dependent=>:delete, :name=>"special_user_records_special_user_id_fk"}'
    end

    it 'should set failure_message_for_should message' do
      stub_fkd_to_s_with('expected fk')
      matcher = have_foreign_key_for(:special_user_records)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{foreign_keys_for('special_user_records')} to include expected fk"
    end

    it 'should set failure_message_for_should_not message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher = have_foreign_key_for(:users, :column => 'special_user_id', :name => 'special_user_records_special_user_id_fk', :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{foreign_keys_for('special_user_records')} to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :column => 'special_user_id', :dependent => :delete) }
    it { should have_foreign_key_for(:users, :column => 'special_user_id', :dependent => :delete) }
    it { should have_foreign_key_for(:user_type, :column => 'special_user_type_id', :name => 'special_user_type_fk') }
    it { should have_foreign_key_for(:user_types, :column => 'special_user_type_id', :name => 'special_user_type_fk') }
  end
end
