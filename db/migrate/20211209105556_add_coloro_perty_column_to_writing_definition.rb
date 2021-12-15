class AddColoroPertyColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :color, :string, default: "#000"
  end
end
