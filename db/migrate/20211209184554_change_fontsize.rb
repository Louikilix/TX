class ChangeFontsize < ActiveRecord::Migration[6.1]
  def change
    change_column_default :writing_definitions, :font_size, 50
    change_column_default :writing_definitions, :font_family, "Times"
  end
end
