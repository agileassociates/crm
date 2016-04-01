class CreateCustomerDetailsMaterializedView < ActiveRecord:: Migration
  def up
    execute %{
      CREATE MATERIALIZED VIEW customer_details AS SELECT
  customers.id                AS id,
  customers.first_name        AS first_name,
  customers.last_name         AS last_name,
  customers.email             AS email,
  customers.username          AS username,
  customers.created_at        AS joined_at,
  billing_address.id          AS billing_address_id,
  billing_address.street      AS billing_street,
  billing_address.city        AS billing_city,
  billing_state.code          AS billing_state,
  billing_address.zipcode     AS billing_zipcode,
  shipping_address.id         AS shipping_address_id,
  shipping_address.street     AS shipping_street,
  shipping_address.city       AS shipping_city,
  shipping_state.code         AS shipping_state,
  shipping_address.zipcode    AS shipping_zipcode
  FROM
  customers
  JOIN customer_billing_address
  ON customers.id = customer_billing_address.id JOIN address billing_address
  ON billing_address.id = customer_billing_address.address_id JOIN state billing_state
  ON billing_address.state_id = billing_state.id JOIN customer_shipping_address
  ON customers.id = customer_shipping_address.id AND customer_shipping_address.primary = true
  JOIN address shipping_address ON shipping_address.id = customer_shipping_address.address_id
  JOIN state shipping_state ON shipping_address.state_id = shipping_state.id
  }
    execute %{
    CREATE UNIQUE INDEX
      customers_details_customer_id ON customer_details( id )
  }
  end

  def down
    execute "DROP MATERIALIZED VIEW customer_details"
  end

end