class CreateShops < ActiveRecord::Migration
  def self.up
    create_table :shops  do |t|
      t.string :shop, null: false
      t.string :token, null: true
      t.string :email, null: false
      t.string :password, null: false
      t.timestamps
    end

    add_index :shops, :shop, unique: true
  end

  def self.down
    drop_table :shops
  end
end
