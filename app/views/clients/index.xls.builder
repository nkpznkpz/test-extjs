excel_document(xml) do
  xml.Worksheet 'ss:Name' => 'Client' do
    xml.Table do
      xml.Column 'ss:Width' => '80'
      xml.Column 'ss:Width' => '200'
      xml.Column 'ss:Width' => '200'
      # Header
      xml.Row do
        xml.Cell 'ss:StyleID' => 'header_style' do
          xml.Data 'ID', 'ss:Type' => 'String'
        end
        xml.Cell 'ss:StyleID' => 'header_style' do
          xml.Data 'Client Name', 'ss:Type' => 'String'
        end
        xml.Cell 'ss:StyleID' => 'header_style' do
          xml.Data 'Country Name', 'ss:Type' => 'String'
        end
      end

      # Rows
      for client in @clients
        xml.Row do
          xml.Cell 'ss:StyleID' => 'body_style' do
            xml.Data client.id, 'ss:Type' => 'Number'
          end
          xml.Cell 'ss:StyleID' => 'body_style' do
            xml.Data client.name, 'ss:Type' => 'String'
          end
          xml.Cell 'ss:StyleID' => 'body_style' do
            xml.Data client.country_name, 'ss:Type' => 'String'
          end
        end
      end

    end
  end
end

