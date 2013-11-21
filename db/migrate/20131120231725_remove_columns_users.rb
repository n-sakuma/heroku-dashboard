class RemoveColumnsUsers < ActiveRecord::Migration

  def up
    remove_columns :users, :password_digest, :admin
  end

  def down
    add_column :users, :password_digest, :string
    add_column :users, :admin, :boolean
  end
end
