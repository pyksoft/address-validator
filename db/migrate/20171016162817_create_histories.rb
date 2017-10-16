class CreateHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :histories do |t|
      t.string :country
      t.string :shipping_address

      t.timestamps
    end
  end
end
