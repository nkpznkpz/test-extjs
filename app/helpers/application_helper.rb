# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def data_for_sel(obj,name,val)
    if obj.count != 0
      options ='{'
      options << %Q/value:":-----;/
      obj.each do |o|
        options << "%s:%s;" % [o.send(name), o.send(val)]
      end
      options.chop! << %Q/",/
      options.chop! << "}"
    else
      options= '{value:":-----"}'
    end
  end
  def to_date_str(d)
    if !d.nil?
      d.strftime('%d-%b-%Y')
    end
  end
  def excel_document(xml, &block)

    xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    xml.Workbook({
        'xmlns'      => "urn:schemas-microsoft-com:office:spreadsheet",
        'xmlns:o'    => "urn:schemas-microsoft-com:office:office",
        'xmlns:x'    => "urn:schemas-microsoft-com:office:excel",
        'xmlns:html' => "http://www.w3.org/TR/REC-html40",
        'xmlns:ss'   => "urn:schemas-microsoft-com:office:spreadsheet"
      }) do
      xml.Styles do        
        xml.Style 'ss:ID' => 'Default', 'ss:Name' => 'Normal' do
          xml.Alignment 'ss:Vertical' => 'Bottom'
          xml.Borders
          xml.Font 'ss:FontName' => 'Verdana'
          xml.Interior
          xml.NumberFormat
          xml.Protection
        end

        xml.Style 'ss:ID' => 'header_style', 'ss:Name' => 'header_style' do
          xml.Alignment 'ss:Vertical' => 'Center', 'ss:Horizontal' => 'Center'
          xml.Borders do
            xml.Border 'ss:Position' => 'Bottom', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Left', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Right', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Top', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
          end
          xml.Font 'ss:FontName' => 'tahoma', 'ss:Bold' => "1"
          xml.Interior 'ss:Color' => '#BFBFBF', 'ss:Pattern' => 'Solid'
          xml.NumberFormat
          xml.Protection
        end

        xml.Style 'ss:ID' => 'body_style', 'ss:Name' => 'body_style' do
          xml.Alignment 'ss:Vertical' => 'Bottom'
          xml.Borders do
            xml.Border 'ss:Position' => 'Bottom', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Left', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Right', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
            xml.Border 'ss:Position' => 'Top', 'ss:LineStyle' => 'Continuous', 'ss:Weight' => '1'
          end
          xml.Font 'ss:FontName' => 'tahoma', 'ss:Bold' => "1"
          xml.Interior
          xml.NumberFormat
          xml.Protection
        end

      end

      yield block

    end
  end
end
