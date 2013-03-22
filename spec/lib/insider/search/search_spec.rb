require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/search/search_criteria.rb'
describe "insider search" do
	describe "search" do
		it "#authenticate" do
			result = Insider::Search::authenticate
			expect(result).to_not eq nil
			expect(result).to_not eq ''
		end
		describe "use q" do
			it "#search with results" do
				result = Insider::Search::search
				expect(result.class).to eq Insider::Search::SearchOutput
			end
			it "#search with results" do
				result = Insider::Search::search(q = 'xxxxxxx') 
				expect(result.class).to eq Insider::Search::SearchOutput
			end
			it "#search rcs code (G:A - Europe)" do
				result = Insider::Search::search(q = 'rcs:G%5C:A') 
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to be > 0
			end
		end
		describe "xml" do
			it "#search using default search criteria" do
				search_criteria =  Insider::Search::SearchCriteria::formatted_output
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to be > 0
				result.media_items.each do |m|
					expect(m.group_channel_id).to eq 3
				end	
			end
			it "#search using group channel name" do
				input = {:includes => [{:type => 'groupchannelname', 
					                      :text => 'Reuters Insider'}]}
				search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				result.media_items.each do |m|
					expect(m.group_channel_id).to eq 3
				end
			end
			it "#search using media_item_id" do
				input = {:includes => [{:type => 'clip_id', :id => 1044426}]}
				search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to eq 1
			end
			it "#search using media_item_id" do
				input = {:includes => [{:type => 'dynamic:pl'}]}
				search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to eq 5
			end
			it "#search using ticker" do
				input = {:includes => [{:type => 'ticker', :text => 'msft'}]}
				search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to be > 0
			end
			it "#search using rcs" do
				input = {:includes => [{:type => 'care', :id => "G\:A"}]}
				search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
				result = Insider::Search::search(search_criteria)
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to be > 0
			end
			describe "use date" do
				it "before_date with scheduled" do
					input = {:before_date => (DateTime.now - 1).to_s}
					search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
					result = Insider::Search::search(search_criteria, {:type_filter => 'scheduled'})
					expect(result.class).to eq Insider::Search::SearchOutput
					expect(result.media_items.length).to eq 0
				end
				it "after_date with ondemand" do
					input = {:after_date => (DateTime.now + 1).to_s}
					search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
					result = Insider::Search::search(search_criteria, {:type_filter => 'ondemand'})
					expect(result.class).to eq Insider::Search::SearchOutput
					expect(result.media_items.length).to eq 0
				end
			end
		end
	end
end
