class AddShopToHistory < ActiveRecord::Migration[5.1]
  def change
    add_column :histories, :shop, :string
  end
end
