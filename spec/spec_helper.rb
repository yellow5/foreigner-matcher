require 'yaml'
require 'active_record'
require 'foreigner-matcher'
require 'rails/railtie'
require 'foreigner'

# Open a database connection
db_config = YAML::load(File.open("#{File.dirname(__FILE__)}/config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

foreigner_railtie = Foreigner::Railtie.new
foreigner_railtie.run_initializers(foreigner_railtie)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
