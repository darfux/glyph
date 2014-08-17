class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :account
      t.string :nickname
      t.string :password_digest

      t.timestamps
    end
  end
end
