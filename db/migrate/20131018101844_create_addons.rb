class CreateAddons < ActiveRecord::Migration
  def change
    create_table :addons do |t|
      t.references :heroku_app, index: true

      t.string :name
      t.string :description
      t.integer :price_cent, default: 0
      t.string :plan_description
      t.string :group_description
      t.string :sso_url

      t.timestamps
    end
  end
end
