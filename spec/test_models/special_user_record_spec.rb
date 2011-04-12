require 'spec_helper'

describe SpecialUserRecord do
  describe 'messages' do
    it "should contain a description" do
      matcher = have_foreign_key_for(:users, :column => "special_user_id", :name => "special_user_records_special_user_id_fk", :dependent => :delete)
      matcher.description.should == "have a foreign key for users with {:column=>\"special_user_id\", :dependent=>:delete, :name=>\"special_user_records_special_user_id_fk\"}"
    end

    it "should set failure_message_for_should message" do
      matcher = have_foreign_key_for(:special_user_records)
      matcher.matches?(subject)
      matcher.failure_message_for_should.should == "expected #{subject.connection.foreign_keys('special_user_records')} to include #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('special_user_records', 'special_user_records', :primary_key => 'id', :column => 'special_user_record_id', :name => 'special_user_records_special_user_record_id_fk')}"
    end

    it "should set failure_message_for_should_not message" do
      matcher = have_foreign_key_for(:users, :column => "special_user_id", :name => "special_user_records_special_user_id_fk", :dependent => :delete)
      matcher.matches?(subject)
      matcher.failure_message_for_should_not.should == "expected #{subject.connection.foreign_keys('special_user_records')} to exclude #{Foreigner::ConnectionAdapters::ForeignKeyDefinition.new('special_user_records', 'users', :primary_key => 'id', :column => 'special_user_id', :name => 'special_user_records_special_user_id_fk', :dependent => :delete)}"
    end
  end

  describe 'matcher' do
    it { should have_foreign_key_for(:user, :column => "special_user_id", :name => "special_user_records_special_user_id_fk", :dependent => :delete) }
    it { should have_foreign_key_for(:users, :column => "special_user_id", :name => "special_user_records_special_user_id_fk", :dependent => :delete) }
  end
end
