class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :package
      t.integer :amount
      t.references :user
      t.timestamps
    end
  end
end
