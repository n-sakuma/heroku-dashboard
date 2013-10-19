class AddColumnAddonCountToHerokuApps < ActiveRecord::Migration
  def change
    add_column :heroku_apps, :addon_count, :integer, null: false, default: 0
  end
end
