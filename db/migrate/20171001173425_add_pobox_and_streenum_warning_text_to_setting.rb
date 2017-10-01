class AddPoboxAndStreenumWarningTextToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :text_pobox_warning, :text, default: 'PO BOX Warning'
    add_column :settings, :text_streetnum_warning, :text, default: 'Missing street number'
  end
end
