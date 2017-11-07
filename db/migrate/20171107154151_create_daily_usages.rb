class CreateDailyUsages < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_usages do |t|
      t.float :price

      t.timestamps
    end
  end
end
