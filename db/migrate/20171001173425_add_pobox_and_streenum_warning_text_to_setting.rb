class AddPoboxAndStreenumWarningTextToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :text_pobox_warning, :text, default: 'We cannot deliver to a P.O. Box. Please provide a valid street address.'
    add_column :settings, :text_streetnum_warning, :text, default: 'Please specify a street number.'
  end
end
