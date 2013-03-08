require 'nokogiri'
require 'open-uri'
require 'rest_client'

module Insider
	module Search
		attr_accessor :api_token
		def self.search(q = 'channelid:3', options = {})
			default_options = {
				:per_page => '50',
				:page => '1'
			}
			default_options.merge!(options)
			@api_token = authenticate
			url = "http://service.insider.thomsonreuters.com/services/media_items/search.xml?"
			url += "api_token=#{@api_token}&"
			default_options.each do |key, value|
				url += "#{key.to_s}=#{value}&"
			end
			unless Nokogiri::XML(q).errors.empty?
				url += "q=#{q}"
				xml = Nokogiri::XML RestClient.get(url)
			else
				puts 'using post'
				xml = Nokogiri::XML RestClient.post(url, q, :accept => :xml)
			end
		end
		private
		def self.authenticate
			email = 'kevin.williams@sidusa.com'
			password = 'sidusa123'
			url = "http://service.insider.thomsonreuters.com/security/authenticate.xml?login=#{email}&password=#{password}"
			xml = Nokogiri::XML open(url)
			xml.xpath('//api_token').text
		end
	end
end
