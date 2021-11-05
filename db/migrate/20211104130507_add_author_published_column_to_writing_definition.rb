class AddAuthorPublishedColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :author_published, :boolean, default:false
  end
end
