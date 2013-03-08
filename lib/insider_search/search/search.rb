require 'nokogiri'
require 'open-uri'

module InsiderSearch
	module Search
		attr_accessor :api_token
		def self.search(q = '',per_page = '50', page = '1')
			@api_token = authenticate
			puts @api_token
			url = "http://service.insider.thomsonreuters.com/services/media_items/search.xml?q=channelid:3&api_token=#{@api_token}&per_page=#{per_page}&page=#{page}"
			xml = Nokogiri::XML open(url)
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
