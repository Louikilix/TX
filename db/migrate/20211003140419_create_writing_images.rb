class CreateWritingImages < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_images do |t|

      t.timestamps
    end
  end
end
