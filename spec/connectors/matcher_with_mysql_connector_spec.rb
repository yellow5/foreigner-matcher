require 'spec_helper'

describe "Matcher using MySQL connector" do
  before do
    test_with_connector('mysql')
  end

  it 'should do a sanity check for the mysql connector' do
    ActiveRecord::Base.connection.adapter_name.downcase.should == 'mysql'
  end
end
