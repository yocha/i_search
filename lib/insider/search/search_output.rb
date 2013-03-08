require_relative 'search.rb'
require_relative '../media_item/media_item.rb'
module Insider
	module Search
		class SearchOutput
			attr_accessor :no_ondemand
			attr_accessor :no_scheduled
			attr_accessor :search_criteria
			attr_accessor :media_items
			def initialize(q = 'channelid:3', options = {})
				result = Insider::Search::search(q, options)
        @no_ondemand = result.xpath('//search_stats').first.attributes['ondemand_hits'].text.to_i
        @no_scheduled = result.xpath('//search_stats').first.attributes['scheduled_hits'].text.to_i
				@search_criteria = result.at('search_criteria').text
				@media_items = result.xpath('//media_items/media_item').map {|m| Insider::MediaItem.new(m)}
			end
		end
	end
end
