require 'spec_helper'
require 'resolv'

data_files = SeoTestCases.data_files('dns')

describe 'DNS' do

  dns_114 = Resolv::DNS.new(:nameserver => ['114.114.114.114'])
  dns_local = Resolv::DNS.new()
  dns_hosts = Resolv::Hosts.new()

  data_files.each do |file|
    SeoTestCases.load_csv(file).each do |row|
      domain = row['domain']
      begin
        ip_hosts = dns_hosts.getaddress(domain)
      rescue Resolv::ResolvError
        ip_hosts = nil
      end
      ip_local = ip_hosts || dns_local.getaddress(domain)
      ip_114 = dns_114.getaddress(domain)

      it "#{domain} local_ip should be same with 114_ip" do
        expect(ip_local.to_s).to eq(ip_114.to_s)
      end
    end
  end
end