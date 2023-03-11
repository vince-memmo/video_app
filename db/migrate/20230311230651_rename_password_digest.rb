class RenamePasswordDigest < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :passwrd_digest, :password_digest
  end
end
