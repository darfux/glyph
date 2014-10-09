class AddNameAndMajorToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.column :name, :string
      t.column :major, :string
    end
  end
end
