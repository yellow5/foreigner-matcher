require 'bundler'
Bundler::GemHelper.install_tasks

namespace :db do
  namespace :test do
    desc "Reset the test database"
    task :reset do
      require 'yaml'
      require 'active_record'
      require 'rails/railtie'

      def print_table_creation(new_table)
        print "\tCreating #{new_table}..."
        yield
        print "done\n"
      end

      def print_foreign_key_creation(fk_table)
        print "\tCreating key on #{fk_table}..."
        yield
        print "done\n"
      end

      puts "Establishing connection to test db..."
      db_config = YAML::load(File.open("#{File.dirname(__FILE__)}/spec/config/database.yml"))
      ActiveRecord::Base.establish_connection(db_config)
      conn = ActiveRecord::Base.connection
      puts "Connected to #{db_config['database']} via a #{db_config['adapter']} connector"

      puts "\nDropping test tables, if they exist"
      %w( user_logins user_types comments searches special_user_records table_without_foreign_keys users ).each do |test_table|
        print "\tDropping #{test_table}..."
        conn.execute("drop table if exists #{test_table}")
        print "done\n"
      end

      puts "\nCreating test tables"
      print_table_creation('users') do
        conn.create_table(:users) do |t|
          t.string :username
          t.string :email, :default => 'nobody@localhost'
        end
      end
      print_table_creation('special_user_records') do
        conn.create_table(:special_user_records) do |t|
          t.integer :special_user_id
        end
      end
      [ :user_logins, :user_types, :comments, :searches, :table_without_foreign_keys ].each do |user_table|
        print_table_creation(user_table) do
          conn.create_table(user_table) do |t|
            t.integer :user_id
          end
        end
      end

      require 'foreigner'
      foreigner_railtie = Foreigner::Railtie.new
      foreigner_railtie.run_initializers(foreigner_railtie)

      puts "\nCreating foreign keys"
      print_foreign_key_creation('user_logins') { conn.add_foreign_key(:user_logins, :users, :dependent => :nullify) }
      print_foreign_key_creation('user_types') { conn.add_foreign_key(:user_types, :users, :dependent => :restrict) }
      print_foreign_key_creation('comments') { conn.add_foreign_key(:comments, :users, :dependent => :delete) }
      print_foreign_key_creation('searches') { conn.add_foreign_key(:searches, :users, :name => "user_search_special_fk", :dependent => :delete) }
      print_foreign_key_creation('special_user_records') { conn.add_foreign_key(:special_user_records, :users, :column => "special_user_id", :dependent => :delete) }
    end
  end
end
