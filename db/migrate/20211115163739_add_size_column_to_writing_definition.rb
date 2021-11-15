class AddSizeColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :w, :float, default: 0
    add_column :writing_definitions, :h, :float, default: 0
  end
end
