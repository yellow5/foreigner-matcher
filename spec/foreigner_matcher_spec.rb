require 'spec_helper'

describe ForeignerMatcher::HaveForeignKeyFor do
  describe 'methods' do
    subject { ForeignerMatcher::HaveForeignKeyFor.new(mock) }

    [ :matches?, :description, :failure_message_for_should, :failure_message_for_should_not ].each do |klass_method|
      it "should respond to #{klass_method}" do
        subject.should respond_to(klass_method)
      end
    end
  end
end
