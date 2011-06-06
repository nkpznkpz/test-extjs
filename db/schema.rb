# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100910025438) do

  create_table "client_contact_records", :force => true do |t|
    t.integer  "product_id"
    t.float    "total1"
    t.datetime "request_date"
    t.integer  "client_contract_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_containers", :force => true do |t|
    t.string   "container_code"
    t.string   "seal_code"
    t.float    "container_usage"
    t.integer  "client_shipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_contracts", :force => true do |t|
    t.string   "contract_code"
    t.datetime "contract_date"
    t.boolean  "actual_contract"
    t.integer  "client_id"
    t.string   "status"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_invoice_rates", :force => true do |t|
    t.string   "exchange_rate"
    t.datetime "settlement_date"
    t.integer  "client_invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_invoices", :force => true do |t|
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.float    "total_amount"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_order_fulfillments", :force => true do |t|
    t.integer  "client_invoice_id"
    t.integer  "order_status_id"
    t.integer  "supplier_sku_id"
    t.float    "total_drain_weight"
    t.float    "total_gross_weight"
    t.float    "total_net_weight"
    t.float    "quantity"
    t.float    "container_usage"
    t.integer  "unit_id"
    t.integer  "client_order_id"
    t.integer  "supplier_order_fulfillment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_order_groups", :force => true do |t|
    t.integer  "client_order_fulfillment_id"
    t.integer  "client_container_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_orders", :force => true do |t|
    t.float    "total_quantity"
    t.integer  "client_PO_id"
    t.integer  "trader_sku_id"
    t.string   "request_et"
    t.string   "request_et_type"
    t.string   "unit_of_order"
    t.float    "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_pos", :force => true do |t|
    t.string   "po"
    t.datetime "po_date"
    t.float    "po_amount"
    t.string   "currency"
    t.integer  "client_contract_id"
    t.integer  "payment_term_id"
    t.integer  "payment_term_day"
    t.string   "status"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_psses", :force => true do |t|
    t.datetime "date_sent"
    t.datetime "date_receive"
    t.integer  "pss_status_id"
    t.integer  "client_order_id"
  end

  create_table "client_shipments", :force => true do |t|
    t.string   "shipment_code"
    t.string   "departure_gmt"
    t.string   "departure_port"
    t.datetime "actual_etd"
    t.datetime "actual_eta"
    t.string   "arrival_gmt"
    t.string   "destination_port"
    t.integer  "transit"
    t.string   "place_of_delivery"
    t.datetime "docs_sent_date"
    t.string   "vessel"
    t.string   "remark"
    t.string   "destination_charge"
    t.integer  "inco_term_id"
    t.integer  "shipping_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "country_name"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inco_terms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_terms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_mappings", :force => true do |t|
    t.integer  "trader_sku_id"
    t.integer  "supplier_sku_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "detail"
    t.string   "product_type"
    t.string   "spec"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pss_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipping_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_contact_records", :force => true do |t|
    t.integer  "product_id"
    t.float    "total1"
    t.datetime "request_date"
    t.integer  "supplier_contract_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_containers", :force => true do |t|
    t.string   "container_code"
    t.string   "seal_code"
    t.float    "container_usage"
    t.integer  "supplier_shipment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_contracts", :force => true do |t|
    t.string   "contract_code"
    t.datetime "contract_date"
    t.boolean  "actual_contract"
    t.integer  "supplier_id"
    t.string   "status"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_invoice_rates", :force => true do |t|
    t.string   "exchange_rate"
    t.datetime "settlement_date"
    t.integer  "supplier_invoice_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_invoices", :force => true do |t|
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.float    "total_amount"
    t.datetime "payment_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_order_fulfillments", :force => true do |t|
    t.integer  "supplier_invoice_id"
    t.integer  "order_status_id"
    t.integer  "trader_sku_id"
    t.float    "total_drain_weight"
    t.float    "total_gross_weight"
    t.float    "total_net_weight"
    t.float    "quantity"
    t.float    "container_usage"
    t.integer  "unit_id"
    t.integer  "supplier_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_order_groups", :force => true do |t|
    t.integer  "supplier_order_fulfillment_id"
    t.integer  "supplier_container_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_orders", :force => true do |t|
    t.float    "total_quantity"
    t.integer  "supplier_PO_id"
    t.integer  "supplier_sku_id"
    t.string   "request_et"
    t.string   "request_et_type"
    t.string   "unit_of_order"
    t.float    "unit_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_pos", :force => true do |t|
    t.string   "po"
    t.datetime "po_date"
    t.float    "po_amount"
    t.string   "currency"
    t.integer  "supplier_contract_id"
    t.integer  "payment_term_id"
    t.integer  "payment_term_day"
    t.string   "status"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_psses", :force => true do |t|
    t.datetime "date_sent"
    t.datetime "date_receive"
    t.integer  "pss_status_id"
    t.integer  "supplier_order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_shipments", :force => true do |t|
    t.string   "shipment_code"
    t.string   "departure_gmt"
    t.string   "departure_port"
    t.datetime "actual_etd"
    t.datetime "actual_eta"
    t.string   "arrival_gmt"
    t.string   "destination_port"
    t.integer  "transit"
    t.string   "place_of_delivery"
    t.datetime "docs_sent_date"
    t.string   "vessel"
    t.string   "remark"
    t.string   "destination_charge"
    t.integer  "inco_term_id"
    t.integer  "shipping_status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_skus", :force => true do |t|
    t.string   "sku"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "country_name"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trader_skus", :force => true do |t|
    t.string   "sku"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "name"
    t.string   "unit_per_container"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "privacy"
    t.integer  "status"
    t.string   "username",                           :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
