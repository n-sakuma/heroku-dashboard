class RemoveColumnFromHerokuApps < ActiveRecord::Migration

  def up
    remove_column :heroku_apps, :dynos
    remove_column :heroku_apps, :workers
  end

  def down
    add_column :heroku_apps, :dynos, :integer, default: false
    add_column :heroku_apps, :workers, :integer, default: false
  end
end
