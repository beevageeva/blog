class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_salt
      t.string :password_hash
      t.string :email
      t.string :name
      t.boolean :active
      t.string :account_type

      t.timestamps
    end
  end
end
