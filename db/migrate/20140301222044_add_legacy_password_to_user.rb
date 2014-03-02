class AddLegacyPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :legacy_password, :boolean, default: false
  end
end
