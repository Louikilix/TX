class CreateAdminsWritingInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :admins_writing_informations do |t|
      t.text :text1
      t.text :text2

      t.timestamps
    end
  end
end
