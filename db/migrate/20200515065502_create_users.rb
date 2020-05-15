class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :role
      t.string :email
      t.string :address
      t.string :password_digest
      t.string :password_confirmation_digest
      t.bigint :phone_no
      t.timestamps
    end
  end
end
