class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :payments , :package , :string
  end
end
