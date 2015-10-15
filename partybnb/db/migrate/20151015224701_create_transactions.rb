class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :creditCardNumber
      t.string :cardholderName
      t.string :type
      t.string :securityPass
      t.date :expirationDate
      t.double :price

      t.timestamps null: false
    end
  end
end
