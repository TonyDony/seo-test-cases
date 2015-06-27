require 'spec_helper'
require 'addressabler'
require 'tspider'

data_files = SeoTestCases.data_files('opf')

describe 'OPF' do

  data_files.each do |f|
    rules = []

    SeoTestCases.load_csv(f).each do |row|
      rules << {url: Addressable::URI.parse(row['url']).normalize.to_s, factor: row['factor'], value: row['value'], user_agent: row['user_agent']}
    end

    rules = rules.group_by { |h| h[:url] }
    rules.each do |url, rs|
      rs.each do |rule|
        factor = rule[:factor]
        local_value = rule[:value]

        case rule[:user_agent]
          when nil
            user_agents = { 'PC' => ::Tspider::UA::BAIDU, 'Mobile' => ::Tspider::UA::BAIDU_MOBILE}
          when 'PC'
            user_agents = { 'PC' => ::Tspider::UA::BAIDU}
          when 'Mobile'
            user_agents = { 'Mobile' => ::Tspider::UA::BAIDU_MOBILE}
          else
            user_agents = { rule[:user_agent] => rule[:user_agent]}
        end

        user_agents.each_pair do |user_agent_name, user_agent|
          page = SeoTestCases.get_url(:url => url, :user_agent => user_agent)

          it "should match factor: #{factor}, UA: '#{user_agent_name}', URL: #{url}" do
            online_cache = page.send(factor)
            online_cache = online_cache.join('|') if online_cache.class == Array

            expect(online_cache).to eq(local_value)
          end
        end
      end
    end
  end

end