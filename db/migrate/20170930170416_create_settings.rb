class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.boolean :auto_complete
      t.boolean :validate_address
      t.boolean :pobox_warning
      t.boolean :streetnum_warning
      t.string :store_domain
      t.string :color_background
      t.string :color_border
      t.string :color_text
      t.string :color_highlight
      t.string :color_hover
      t.string :text_apt_suite
      t.string :text_inaccurate
      t.string :text_select_confirm
      t.string :text_select_suggestion
      t.string :text_suggest1
      t.string :text_suggest2
      t.string :text_correct

      t.timestamps
    end
  end
end
