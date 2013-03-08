require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/media_item/media_item.rb'
describe "insider" do
	describe "search clips" do 
		let(:result) {Insider::Search::SearchOutput.new()}
		describe "search_object" do
			it "#init no_ondemand" do
				expect(result.no_ondemand).to be >  0
			end
			it "#init no_scheduled" do
				expect(result.no_scheduled).to be > 0 
			end
			it "#init media_items" do
				expect(result.media_items.count).to be >= 0 
			end
		end
	end
	describe "search clip" do 
		let(:result) {Insider::Search::SearchOutput.new('clipid:1045548')}
		describe "search_object" do
			it "#init no_ondemand" do
				expect(result.no_ondemand).to eq  1
			end
			it "#init no_scheduled" do
				expect(result.no_scheduled).to eq 0 
			end
			it "#init media_items" do
				expect(result.media_items.count).to eq 1 
			end
		end
	end
	describe "search links" do
		let(:result) {Insider::Search::SearchOutput.new('', {:media_types => 'Link'})}
		it "no links" do
			expect(result.media_items.count).to eq 0
		end
	end
end
