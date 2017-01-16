class ChangeLocaleNullForUsers < ActiveRecord::Migration
  def change
    change_column :users, :locale, :string, null: false
  end
end
