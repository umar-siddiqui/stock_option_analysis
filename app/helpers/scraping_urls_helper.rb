require 'open-uri'
require 'csv'
module ScrapingUrlsHelper
  class Pbox
    def initialize (url)
      @url = url
      @doc = Nokogiri::HTML(open(url.url))

      @table_columns = ["BidQty", "BidPrice", "AskPrice", "AskQty", "LTP", "Strike Price", "LTP", "BidQty", "BidPrice", "AskPrice", "AskQty"]
      @header_content = []
      @body_content = []
    end

    def calculate
      get_underlying
      table_header_content
      table_body_content
      generate_table
    end

    def get_underlying
      @underlying_index = @doc.search('span:contains("Underlying Index")').search('b')[0].content
    end

    def table_header_content
      @doc.search('div.opttbldata table thead tr')[1]
          .search('th').each {|th| @header_content << th.content.strip}
    end

    def table_body_content
      @doc.search('div.opttbldata table tr').drop(2).each do |row|
        content = []
        row.search('td').each {|td| content << td.content.strip}
        @body_content << content
      end
    end

    def generate_table
      header_indices = []
      @header_content.each_with_index do |item, index|
        header_indices << index if @table_columns.include? item
      end

      stock_headers = @header_content.values_at(*header_indices)
      stock_rows = []

      @body_content.each do |content|
        stock_rows << content.values_at(*header_indices)
      end

      pbox = calculate_pbox(stock_rows)
      generate_csv(stock_headers, stock_rows, pbox)
      pbox
    end

    def generate_csv(stock_headers, stock_rows, pbox)
      csv_name = 'public/csv_files/stock_option_chain_' + pbox.id.to_s + '.csv'
      CSV.open(csv_name, "wb") do |csv|
        csv << [@underlying_index]
        csv << stock_headers
        stock_rows.each do |row|
          csv << row
        end
      end
    end

    def calculate_pbox (stock_rows)
      u_indx = @underlying_index.gsub(/\s+/m, ' ')
                                .gsub(/^\s+|\s+$/m, '').split(" ")[1].to_f
      sci = nil
      ltp_sci = nil
      sco = nil
      ltp_sco = nil
      spi = nil
      ltp_spi = nil
      spo = nil
      ltp_spo = nil

      #fetch sci,ltp_sci,sco,ltp_sco
      stock_rows.each do |row|
        call_ltp = row[0].to_f
        put_ltp = row[10].to_f
        strike_price = row[5].to_f

        if strike_price < u_indx && call_ltp != 0.0
          sci = strike_price
          ltp_sci = call_ltp
        end

        if strike_price > u_indx && call_ltp != 0.0
          sco = strike_price
          ltp_sco = call_ltp
          break;
        end
      end

      #fetch spo,ltp_spo,spi,ltp_spi
      stock_rows.each do |row|
        call_ltp = row[0].to_f
        put_ltp = row[10].to_f
        strike_price = row[5].to_f

        if strike_price < u_indx && put_ltp != 0.0
          spo = strike_price
          ltp_spo = put_ltp
        end

        if strike_price > u_indx && put_ltp != 0.0
          spi = strike_price
          ltp_spi = put_ltp
          break;
        end
      end

      pbox = (sco - sci) - ((ltp_sco + ltp_spo) - (ltp_sci + ltp_spi))

      pbox = {
        sci: sci,
        ltp_sci: ltp_sci,
        sco: sco,
        ltp_sco: ltp_sco,
        spi: spi,
        ltp_spi: ltp_spi,
        spo: spo,
        ltp_spo: ltp_spo,
        pbox_value: pbox
      }
      @url.pboxes.create!(pbox)
    end
  end
end