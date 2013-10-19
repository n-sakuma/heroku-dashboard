class RemoveColumnPriceCentFromAddons < ActiveRecord::Migration
  def change
    remove_column :addons, :price_cent, :integer
  end
end
