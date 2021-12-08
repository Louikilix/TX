class AddTextColumnsToWritingInformations < ActiveRecord::Migration[6.1]
  def change
    add_column :writing_informations, :text3, :text
    add_column :writing_informations, :text4, :text
    add_column :writing_informations, :text5, :text
    add_column :writing_informations, :text6, :text
  end
end
