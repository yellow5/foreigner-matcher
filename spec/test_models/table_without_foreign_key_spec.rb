require 'spec_helper'

describe TableWithoutForeignKey do
  describe 'messages' do
    let(:matcher) { have_foreign_key_for(:users) }

    it 'should contain a description' do
      matcher.description.should == 'have a foreign key for users'
    end

    it 'should set failure_message message' do
      stub_fkd_to_s_with('expected fk')
      matcher.matches?(subject)
      matcher.failure_message.should == "expected foreign keys to include expected fk"
    end

    it 'should set failure_message_when_negated message' do
      stub_fkd_to_s_with('unexpected fk')
      matcher.matches?(subject)
      matcher.failure_message_when_negated.should == "expected foreign keys to exclude unexpected fk"
    end
  end

  describe 'matcher' do
    it { should_not have_foreign_key_for(:user) }
    it { should_not have_foreign_key_for(:users) }
  end
end
