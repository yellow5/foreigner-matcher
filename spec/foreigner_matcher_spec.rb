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

  describe 'matcher' do
    describe UserType do
      subject { UserType.new }

      it { should have_foreign_key_for(:user) }
    end

    describe UserLogin do
      subject { UserLogin.new }

      it { should have_foreign_key_for(:user, :dependent => :nullify) }
    end

    describe Comment do
      subject { Comment.new }

      it { should have_foreign_key_for(:user, :dependent => :delete) }
    end

    describe Search do
      subject { Search.new }

      it { should have_foreign_key_for(:user, :name => "user_search_special_fk", :dependent => :delete) }
    end

    describe SpecialUserRecord do
      subject { SpecialUserRecord.new }

      it { should have_foreign_key_for(:user, :column => "special_user_id", :name => "special_user_records_special_user_id_fk", :dependent => :delete) }
    end

    describe TableWithoutForeignKey do
      subject { TableWithoutForeignKey.new }

      it { should_not have_foreign_key_for(:user) }
    end
  end
end
