class AddFinishedColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :finished, :boolean, default: false
  end
end
