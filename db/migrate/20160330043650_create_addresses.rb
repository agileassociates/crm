class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :state do |t|
      t.string :code, size: 2, null: false
      t.string :name,          null: false
    end


    create_table :address do |t|
      t.string        :street,        null: false
      t.string        :city,          null: false
      t.references    :state,         null: false
      t.string        :zipcode,       null: false
    end

    create_table :customer_billing_address do |t|
      t.references :customer,         null: false
      t.references :address,          null: false
    end

    create_table :customer_shipping_address do |t|
      t.references :customer,         null: false
      t.references :address,          null: false
      t.boolean    :primary,          null: false, default: false
    end
  end
end
