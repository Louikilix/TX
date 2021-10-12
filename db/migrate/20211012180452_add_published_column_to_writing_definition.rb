class AddPublishedColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :published, :boolean, default:false
  end
end
