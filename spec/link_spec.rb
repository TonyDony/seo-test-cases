require 'spec_helper'
require 'addressabler'
require 'tspider'

require 'pp'

data_files = SeoTestCases.data_files('link')

describe 'Link' do
  data_files.each do |f|
    rules = []

    SeoTestCases.load_csv(f).each do |row|
      rules << {url: Addressable::URI.parse(row['url']).normalize.to_s,
                href: row['href'],
                text: row['text'].to_s,
                rel: row['rel'],
                disallow: (row['disallow'] == 'true'),
                user_agent: row['user_agent']}
    end

    rules.each do |rule|
      case rule[:user_agent]
        when nil
          user_agents = {'PC' => ::Tspider::UA::BAIDU, 'Mobile' => ::Tspider::UA::BAIDU_MOBILE}
        when 'PC'
          user_agents = {'PC' => ::Tspider::UA::BAIDU}
        when 'Mobile'
          user_agents = {'Mobile' => ::Tspider::UA::BAIDU_MOBILE}
        else
          user_agents = {rule[:user_agent] => rule[:user_agent]}
      end

      user_agents.each_pair do |user_agent_name, user_agent|
        page = SeoTestCases.get_url(:url => rule[:url], :user_agent => user_agent)

        it "should include link: #{rule}" do
          links = page.links

          matches = links.select{|row| row[:href] == rule[:href] && row[:text] == rule[:text] && row[:rel] == rule[:rel] && (row[:disallow] == rule[:disallow] || row[:disallow].nil?)}
          expect(matches.size).to be > 0
        end
      end
    end
  end
end
