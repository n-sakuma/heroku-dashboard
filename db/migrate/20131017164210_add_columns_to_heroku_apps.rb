class AddColumnsToHerokuApps < ActiveRecord::Migration
  def change
    add_column :heroku_apps, :dynos, :integer, default: 0
    add_column :heroku_apps, :workers, :integer, default: 0
    add_column :heroku_apps, :web_url, :string
    add_column :heroku_apps, :released_at, :datetime
  end
end
