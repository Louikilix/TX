class AddAuthorSignatureColumnToWritingDefinition < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_definitions, :author_signature, :string
  end
end
