module ConnectionHelpers
  def foreign_keys_for(table_name)
    ActiveRecord::Base.connection.foreign_keys(table_name)
  end

  def postgresql_db?
    ActiveRecord::Base.connection.adapter_name.downcase == 'postgresql'
  end
end
