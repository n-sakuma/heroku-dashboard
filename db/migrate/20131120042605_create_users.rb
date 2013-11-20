class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :access_token
      t.datetime :access_token_expired_at
      t.boolean :admin

      t.timestamps
    end
  end
end
