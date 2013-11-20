class AddColumnPriceToAddons < ActiveRecord::Migration

  def up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    add_column :addons, :price, :hstore
  end

  def down
    remove_column :addons, :price
    execute "DROP EXTENSION IF EXISTS hstore"
  end
end
