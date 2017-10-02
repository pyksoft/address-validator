class AddWarningColorsToSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :color_background_warning, :string, default: 'fcf8e3'
    add_column :settings, :color_border_warning, :string, default: 'faf2cc'
    add_column :settings, :color_text_warning, :string, default: '8a6d3b'
  end
end
