class CreateHerokuApps < ActiveRecord::Migration
  def change
    create_table :heroku_apps do |t|
      t.string :name

      t.timestamps
    end
  end
end
