class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :email
      t.string :token
      t.integer :amount
      t.references :user
      t.timestamps
    end
  end
end
