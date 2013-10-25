class AddColumnAsyncRunningToHerokuApp < ActiveRecord::Migration
  def change
    add_column :heroku_apps, :async_running, :boolean, default: false
  end
end
