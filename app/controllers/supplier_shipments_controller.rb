class SupplierShipmentsController < ApplicationController
  protect_from_forgery :except => [:shipmentst_data]

  def index
    supplier_shipments = SupplierShipment.find(:all, :include => [:inco_term,:shipping_status]) do
      if params[:_search] == "true"
        shipment =~ "%#{params[:shipment]}%" if params[:shipment].present?
        shipment_date == Date.parse(params[:shipment_date]) if params[:shipment_date].present?
      end
      paginate :page => params[:page], :per_page => params[:rows]
      order_by "#{params[:sidx]} #{params[:sord]}"
    end
    #get payment_term_name
    supplier_shipments.collect do |item|
      #item[:payment_term_name] = item.payment_term.name
      #item[:shipment_date_s] = to_date_str(item.shipment_date)
      item[:actual_etd_s] = to_date_str(item.actual_etd)
      item[:actual_eta_s] = to_date_str(item.actual_eta)
      item[:docs_sent_date_s] = to_date_str(item.docs_sent_date)
    end
    if request.xhr?
      render :json => supplier_shipments.to_jqgrid_json(
        [
          :id,:shipment_code,:departure_gmt,:departure_port,:actual_etd_s,:actual_eta_s,:arrival_gmt,
          :destination_port,:transit,:place_of_delivery,:docs_sent_date_s,:vessel,:remark,:destination_charge,:inco_term_id,:shipping_status_id
        ],
        params[:page], params[:rows], supplier_shipments.total_entries) and return
    end
  end

  def post_data
    response_data = {}
    if params[:oper] == "del"
      supplier_shipment = SupplierShipment.find(params[:id])
      if !supplier_shipment.destroy
        supplier_shipment.errors.add_to_base('Cannot delete supplier PO in use.')
      end
    else
      supplier_shipment_params = {
        :shipment_code => params[:shipment_code],
        :departure_gmt => params[:departure_gmt],
        :departure_port => params[:departure_port],
        :actual_etd => params[:actual_etd],
        :actual_eta => params[:actual_eta],
        :arrival_gmt => params[:arrival_gmt],
        :destination_port => params[:destination_port],
        :transit => params[:transit],
        :place_of_delivery => params[:place_of_delivery],
        :docs_sent_date => params[:docs_sent_date],
        :vessel => params[:vessel],
        :remark => params[:remark],
        :destination_charge => params[:destination_charge],
        :inco_term_id => params[:inco_term_id],
        :shipping_status_id => params[:shipping_status_id]
      }
      if params[:id] == "_empty"
        supplier_shipment = SupplierShipment.create(supplier_shipment_params)
        response_data[:id] = supplier_shipment.id
      else
        supplier_shipment = SupplierShipment.find(params[:id])
        supplier_shipment.update_attributes(supplier_shipment_params)
      end
    end
    #display error messages
    err = ""
    if supplier_shipment
      supplier_shipment.errors.entries.each do |error|
        err << "<strong>#{error[0]}</strong> : #{error[1]}<br/>"
      end
      response_data[:error] = err
    end
    render :json => response_data
  end

end
