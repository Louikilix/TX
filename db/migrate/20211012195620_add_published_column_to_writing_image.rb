class AddPublishedColumnToWritingImage < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_images, :published, :boolean, default:false
  end
end
