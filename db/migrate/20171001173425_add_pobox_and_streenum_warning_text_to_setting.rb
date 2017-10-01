class AddPoboxAndStreenumWarningTextToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :text_pobox_warning, :text
    add_column :settings, :text_streetnum_warning, :text
  end
end
