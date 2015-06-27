require 'spec_helper'
require 'tspider'
require 'addressabler'

data_files = SeoTestCases.data_files('redirect')

describe 'Redirect' do

  data_files.each do |f|
    rules = []

    SeoTestCases.load_csv(f).each do |row|
      rules << {url: Addressable::URI.parse(row['url']).normalize.to_s, status: row['status'], location: row['location']}
    end

    rules = rules.group_by { |h| h[:url] }

    rules.each do |url, rs|
      page = Tspider.get(url,:user_agent => ::Tspider::UA::BAIDU, :verify => FALSE)
      rs.each do |rule|
        will = [rule[:status].to_i,rule[:location]]

        it "#{url} should #{will}" do
          online_cache = [page.status,page.location||url]

          expect(online_cache).to eq(will)
        end
      end
    end
  end

end