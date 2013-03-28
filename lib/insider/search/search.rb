require 'nokogiri'
require 'open-uri'
require 'rest_client'
require_relative 'search_output.rb'

module Insider
	module Search
		DOMAIN = "service.insider.thomsonreuters.com"
		#DOMAIN = "qa.service.reutersinsider.com"
		attr_accessor :api_token
		def self.search(q = 'channelid:3', options = {})
			default_options = {
				:per_page => '50',
				:page => '1'
			}
			default_options.merge!(options)
			@api_token = @api_token || authenticate
			url = "http://#{DOMAIN}/services/media_items/search.xml?"
			url += "api_token=#{@api_token}&"
			default_options.each do |key, value|
				url += "#{key.to_s}=#{value}&"
			end
			unless Nokogiri::XML(q).errors.empty?
				url += "q=#{q}"
				xml = Nokogiri::XML RestClient.get(url)
			else
				xml = Nokogiri::XML RestClient.post(url, q, :content_type => 'application/xml')
			end
			SearchOutput.new(xml)
		end
		private
		def self.authenticate
			email = ''
			password = ''
			url = "http://#{DOMAIN}/security/authenticate.xml?login=#{email}&password=#{password}"
			xml = Nokogiri::XML open(url)
			xml.xpath('//api_token').text
		end
	end
end
