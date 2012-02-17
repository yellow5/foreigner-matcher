module ForeignKeyDefinitionHelpers
  def stub_fkd_to_s_with(string_value='ForeignKeyDefinition.tos')
    Foreigner::ConnectionAdapters::ForeignKeyDefinition.any_instance.stubs(:to_s).returns(string_value)
  end
end
