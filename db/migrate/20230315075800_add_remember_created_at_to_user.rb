class AddRememberCreatedAtToUser < ActiveRecord::Migration[7.0]
  def change
    ## Rememberable
    add_column :users, :remember_created_at, :datetime
  end
end
