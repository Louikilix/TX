class CreateWritingDefinitionsAndWritingImages < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_definitions_images, id: false do |t|
      t.belongs_to :writing_definition
      t.belongs_to :writing_image
    end
  end
end