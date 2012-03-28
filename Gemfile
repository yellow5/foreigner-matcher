source "http://rubygems.org"

# Specify your gem's dependencies in foreigner-matcher.gemspec
gemspec

group :test do
  gem "rake"
  gem "rspec",        "~> 2.9.0"
  gem "mocha",        "~> 0.10.4"
  gem "activerecord", "~> 3.2.0"
  gem "railties",     "~> 3.2.0"

  platforms :ruby do
    gem "mysql2",     "~> 0.3.0"
    gem "pg",         "~> 0.13.2"
  end

  platforms :jruby do
    gem "activerecord-jdbcmysql-adapter"
    gem "activerecord-jdbcpostgresql-adapter"
  end
end
