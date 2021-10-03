class CreateWritingDefinitions < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_definitions do |t|

      t.timestamps
    end
  end
end
