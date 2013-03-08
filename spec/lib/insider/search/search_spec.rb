require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
describe "insider search" do
	describe "search" do
		it "#authenticate" do
			result = Insider::Search::authenticate
			expect(result).to_not eq nil
		end
		it "#search with results" do
			result = Insider::Search::search
			expect(result.xpath('//result/status').text).to eq 'success'
		  media_items = result.xpath('//media_items//media_item')	
			expect(media_items.length).to be >= 0 
		end
		it "#search with results" do
			result = Insider::Search::search(q = 'xxxxxxx') 
			expect(result.xpath('//result/status').text.downcase).to eq 'success'
		  media_items = result.xpath('//media_items//media_item')	
			expect(media_items.length).to eq 0 
		end
	end
end
