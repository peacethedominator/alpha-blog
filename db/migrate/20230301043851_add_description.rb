class AddDescription < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :description, :textd
  end
end
