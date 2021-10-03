class AddBodyToWritingDefinitions < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :body, :text
  end
end
