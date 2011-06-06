ActionController::Routing::Routes.draw do |map|
  map.resources :products
  map.resources :users
  map.login "login", :controller => "user_sessions", :action => "create"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.dashboard "dashboard", :controller => "welcome", :action => "dashboard"

  ############################### client #######################################
  map.resources :trader_sku
  map.resources :clients

  map.resources :client_contracts do |client_contracts|
    client_contracts.resources :client_pos do |client_pos|
      client_pos.resources :client_orders do |client_orders|
        client_orders.resources :client_order_fulfillments
      end
    end
  end
  #manage grid path
  map.client_po_grid "client_po/post_data/:client_contract_id",
    :controller => "client_pos", :action => "post_data"
  map.client_po_grid_view "client_po/index/:client_contract_id",
    :controller => "client_pos", :action => "index"

  map.client_order_grid "client_order/post_data/:client_po_id",
    :controller => "client_orders", :action => "post_data"
  map.client_order_grid_view "client_order/index/:client_po_id",
    :controller => "client_orders", :action => "index"

  map.client_order_fulfillment_grid "client_order_fulfillment/post_data/:client_order_id",
    :controller => "client_order_fulfillments", :action => "post_data"
  map.client_order_fulfillment_grid_view "client_order_fulfillment/index/:client_order_id",
    :controller => "client_order_fulfillments", :action => "index"
  map.client_invoice_grid "client_invoice/post_data",
    :controller => "client_invoice", :action => "post_data"
  map.client_invoice_grid_view "client_invoice/index",
    :controller => "client_invoice", :action => "index"
  map.show_client_order_fulfillment_no_invoice_grid_view "client_order_fulfillment/show_client_order_fulfillment_no_invoice",
    :controller => "client_order_fulfillments", :action => "show_client_order_fulfillment_no_invoice"
  ############################### end client #######################################



  ############################### supplier #######################################
  map.resources :supplier_sku
  map.resources :suppliers
  map.resources :supplier_shipment
  
  map.resources :supplier_contracts do |supplier_contracts|
    supplier_contracts.resources :supplier_pos do |supplier_pos|
      supplier_pos.resources :supplier_orders do |supplier_orders|
        supplier_orders.resources :supplier_order_fulfillments
      end
    end
  end
  #manage grid path
  map.supplier_po_grid "supplier_po/post_data/:supplier_contract_id",
    :controller => "supplier_pos", :action => "post_data"
  map.supplier_po_grid_view "supplier_po/index/:supplier_contract_id",
    :controller => "supplier_pos", :action => "index"

  map.supplier_order_grid "supplier_order/post_data/:supplier_po_id",
    :controller => "supplier_orders", :action => "post_data"
  map.supplier_order_grid_view "supplier_order/index/:supplier_po_id",
    :controller => "supplier_orders", :action => "index"

  map.supplier_order_fulfillment_grid "supplier_order_fulfillment/post_data/:supplier_order_id",
    :controller => "supplier_order_fulfillments", :action => "post_data"
  map.supplier_order_fulfillment_grid_view "supplier_order_fulfillment/index/:supplier_order_id",
    :controller => "supplier_order_fulfillments", :action => "index"
  
  map.supplier_shipment_grid "supplier_shipment/post_data/",
    :controller => "supplier_shipments", :action => "post_data"
  map.supplier_shipment_grid_view "supplier_shipment/index/",
    :controller => "supplier_shipments", :action => "index"
  map.supplier_invoice_grid "supplier_invoice/post_data",
    :controller => "supplier_invoice", :action => "post_data"
  map.supplier_invoice_grid_view "supplier_invoice/index",
    :controller => "supplier_invoice", :action => "index"
  map.show_supplier_order_fulfillment_no_invoice_grid_view "supplier_order_fulfillment/show_supplier_order_fulfillment_no_invoice",
    :controller => "supplier_order_fulfillments", :action => "show_supplier_order_fulfillment_no_invoice"
  ############################### end supplier #######################################


  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
