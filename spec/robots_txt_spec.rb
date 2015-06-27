require 'spec_helper'
require 'tspider'

data_files = SeoTestCases.data_files('robots.txt').select{|file| /\.txt$/ === file }

describe 'robots.txt' do

  data_files.each do |f|
    file = File.basename(f).sub(/\.txt$/,'')

    if /^https?_/ === file
      schema = file.split('_')[0]
      site = file.sub(schema+'_','')
    else
      schema = 'http'
      site = file
    end

    it "should OK for #{schema}://#{site}" do
      local_robots_txt = File.open(f).read
      # live_robots_txt = open("#{schema}://#{site}/robots.txt").read
      live_robots_txt = Tspider.get("#{schema}://#{site}/robots.txt", :user_agent => ::Tspider::UA::BAIDU).html
      expect(live_robots_txt).to eq(local_robots_txt)
    end
  end

  
end