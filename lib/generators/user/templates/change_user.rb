class ChangeUsers < ActiveRecord::Migration
  
  def self.up
    add_column :users, :os, :string
    add_column :users, :cid, :string
  end

  def self.down
  end
end