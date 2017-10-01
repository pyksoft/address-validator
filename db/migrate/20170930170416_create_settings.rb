class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.boolean :auto_complete, default: true
      t.boolean :validate_address, default: true
      t.boolean :pobox_warning, default: false
      t.boolean :streetnum_warning, default: false
      t.string :store_domain
      t.string :color_background, default: 'DDFFDD'
      t.string :color_border, default: 'C4E2C4'
      t.string :color_text, default: '111111'
      t.string :color_highlight, default: '2C5DFF'
      t.string :color_hover, default: 'FFF4BB'
      t.string :text_apt_suite, default: 'Did you specify the correct apt/suite/unit?'
      t.string :text_inaccurate, default: 'Is the shipping address correct?'
      t.string :text_select_confirm, default: 'Thanks for confirming your shipping address!'
      t.string :text_select_suggestion, default: 'Your shipping address has been updated!'
      t.string :text_suggest1, 'Please select shipping address'
      t.string :text_suggest2, 'To ensure prompt and accurate delivery, we suggest a modified shipping address.'
      t.string :text_correct, 'Thanks for specifying an accurate shipping address!'

      t.timestamps
    end
  end
end
