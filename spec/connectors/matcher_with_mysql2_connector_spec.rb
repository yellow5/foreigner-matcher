require 'spec_helper'

describe "Matcher using MySQL2 connector" do
  before do
    test_with_connector('mysql2')
  end

  it 'should do a sanity check for the mysql2 connector' do
    ActiveRecord::Base.connection.adapter_name.downcase.should == 'mysql2'
  end
end
