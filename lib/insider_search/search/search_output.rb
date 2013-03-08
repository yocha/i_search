require_relative 'search.rb'
module InsiderSearch
	module Search
		class SearchOutput
			attr_accessor :no_ondeman
			attr_accessor :no_scheduled
			attr_accessor :search_crtieria
			attr_accessor :media_items
			def initialize(q = '')
				media_items = InsiderSearch::Search::search(q)
			end
		end
	end
end
