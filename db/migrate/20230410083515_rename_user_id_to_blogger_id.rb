class RenameUserIdToBloggerId < ActiveRecord::Migration[6.1]
  def change
    rename_column :articles, :user_id, :blogger_id
  end
end
