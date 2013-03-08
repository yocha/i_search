require_relative '../../../../lib/insider_search/search/search.rb'
require_relative '../../../../lib/insider_search/search/search_output.rb'
describe "insider search" do
	describe "search" do
		it "#authenticate" do
			result = InsiderSearch::Search::authenticate
			expect(result).to_not eq nil
		end
		it "#search" do
			result = InsiderSearch::Search::search
		  media_items = result.xpath('//media_items//media_item')	
			expect(media_items.length).to eq 50
		end
	end
	describe "search_object" do
		it "#init" do
			result = InsiderSearch::Search::SearchOutput.new

		end
	end
end
