class CreateDynos < ActiveRecord::Migration
  def change
    create_table :dynos do |t|
      t.references :heroku_app, index: true

      t.string :name
      t.string :status
      t.integer :release_number, default: 0
      t.integer :size, default: 0

      t.timestamps
    end
  end
end
