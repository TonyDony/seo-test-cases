require 'csv'

class SeoTestCases
  def self.data_files(name)
    if ENV['data'].nil?
      Dir[File.expand_path("../../data/#{name}/*",__FILE__)]
    else
      Dir[File.expand_path("../../#{ENV['data']}/#{name}/*",__FILE__)]
    end
  end

  def self.load_csv(file)
    i = 0
    headers = []
    result = []
    File.open(file).each_line do |line|
      i += 1
      line = line.chomp

      case file
        when /\.tsv$/
          row = CSV.parse_line line, :col_sep => "\t"
        when /\.csv$/
          row = CSV.parse_line line
        else
          warn "Unknown file format #{file}"
          return result
      end


      if i == 1
        headers = row
        next
      end

      row = CSV::Row.new(headers,row)
      result << row
    end

    result
  end

  @@url_cache = {}
  def self.get_url(attrs)
    if @@url_cache[attrs].nil?
      page = Tspider.get(attrs[:url], :user_agent => attrs[:user_agent])
      @@url_cache[attrs] = page
      page
    else
      @@url_cache[attrs]
    end

  end


end