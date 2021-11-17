class AddFontPropertiesColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :font_size, :float
    add_column :writing_definitions, :font_family, :string
  end
end
