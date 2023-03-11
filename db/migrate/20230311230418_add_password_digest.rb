class AddPasswordDigest < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :passwrd_digest, :string
  end
end
