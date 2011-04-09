def test_with_connector(connector='mysql2')
  db_config = YAML::load(File.open("#{File.dirname(__FILE__)}/../config/database.yml"))
  db_config['adapter'] = connector
  ActiveRecord::Base.establish_connection(db_config)
end
