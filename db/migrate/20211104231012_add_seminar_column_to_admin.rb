class AddSeminarColumnToAdmin < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :seminar, :boolean, default: false
  end
end
