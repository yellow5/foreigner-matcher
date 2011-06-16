require 'yaml'
require 'active_record'
require 'foreigner-matcher'

# Open a database connection
db_config = YAML::load(File.open("#{File.dirname(__FILE__)}/config/database.yml"))
ActiveRecord::Base.establish_connection(db_config)

# Require foreigner after ActiveRecord connection is establisehd.
require 'foreigner'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
