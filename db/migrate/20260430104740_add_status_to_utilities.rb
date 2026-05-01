class AddStatusToUtilities < ActiveRecord::Migration[8.1]
  def change
    add_column :utilities, :status, :integer
  end
end
