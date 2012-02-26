module ActiveRecordVersionHelpers
  def active_record_version
    [
      ActiveRecord::VERSION::MAJOR,
      ActiveRecord::VERSION::MINOR
    ].join('.').to_f
  end
end
