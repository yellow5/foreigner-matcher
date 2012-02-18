module ConnectionHelpers
  def postgresql_db?
    ActiveRecord::Base.connection.adapter_name.downcase == 'postgresql'
  end
end
