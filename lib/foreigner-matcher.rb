module ForeignerMatcher # :nodoc:

  class HaveForeignKeyFor # :nodoc:
    def initialize(parent, options={})
      @parent  = parent.to_s
      @options = options
    end

    def matches?(child)
      @child = child
      child_foreign_keys.include? foreign_key_definition
    end

    def description
      desc  = "have a foreign key for #{@parent}"
      desc += " with #{ordered_options}" unless @options.empty?
      desc
    end

    def failure_message_for_should
      "expected #{display_child_foreign_keys} to include #{foreign_key_definition}"
    end

    def failure_message_for_should_not
      "expected #{display_child_foreign_keys} to exclude #{foreign_key_definition}"
    end

    private

    def foreign_key_definition
      defaults             = { :primary_key => "id", :column => "#{@parent.singularize}_id" }
      defaults[:name]      = "#{@child.class.table_name}_#{defaults[:column]}_fk"
      defaults[:dependent] = nil if postgresql_db?
      full_options         = defaults.merge(@options)
      Foreigner::ConnectionAdapters::ForeignKeyDefinition.new(@child.class.table_name, @parent.pluralize, full_options)
    end

    def child_foreign_keys
      @child.connection.foreign_keys(@child.class.table_name)
    end

    def ordered_options
      ordered = @options.to_a.sort { |a,b| a[0].to_s <=> b[0].to_s }
      display = "{"
      display << ordered.collect { |opt| "#{opt[0].inspect}=>#{opt[1].inspect}" }.join(', ')
      display << "}"
      display
    end

    def display_child_foreign_keys
      fks = child_foreign_keys
      fks.empty? ? 'foreign keys' : fks
    end

    def postgresql_db?
      ActiveRecord::Base.connection.adapter_name.downcase == 'postgresql'
    end
  end

  # Ensures that parent table has foreign key
  #
  # @param [Symbol] parent the table to check for foreign key
  # @param [Hash] options accepts any option that works with add_foreign_key in Foreigner
  #
  # @option options [String] :primary_key ('id') column referenced on parent table
  # @option options [String] :column (@parent.singluarize + '_id') foreign key column
  # @option options [String] :name (@child.class.table_name + '_' + @parent.singularize + '_id') foreign key index name
  #
  # @example
  #   it { should have_foreign_key_for(:users) }
  #   it { should have_foreign_key_for(:users, :dependent => :delete) }
  #   it { should have_foreign_key_for(:users, :column => "some_column_name", :name => "users_some_column_name_fk") }
  #   it { should_not have_foreign_key_for(:users, :dependent => :nullify) }
  def have_foreign_key_for(parent, options={})
    HaveForeignKeyFor.new(parent, options)
  end

end

if defined?(RSpec)
  RSpec::Matchers.send :include, ForeignerMatcher
elsif defined?(Spec)
  Spec::Runner.configure do |config|
    config.include(ForeignerMatcher)
  end
else
  raise LoadError, 'RSpec/Spec must be loaded so I can be mixed in'
end
