class AddcoordinatesColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :x, :float, default: 0
    add_column :writing_definitions, :y, :float, default: 0
  end
end
