require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/media_item/media_item.rb'
describe "insider" do
	describe "search output" do 
		describe "get using search api" do
			describe "search all" do
				let(:result) {Insider::Search::search()}
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
			describe "search clip" do 
				let(:result) {Insider::Search::search('clipid:1045548')}
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
				let(:result) {Insider::Search::search('', {:media_types => 'Link'})}
				it "no links" do
					expect(result.media_items.count).to eq 0
				end
			end
		end
		describe "attributes" do
			let(:search_output) {Insider::Search::SearchOutput.new(Nokogiri::XML(File.open('spec/fixtures/search_result.xml')))}
			it "#no_ondemand" do
				expect(search_output.no_ondemand).to eq 152611 
			end
			it "#no_schdeduled" do
				expect(search_output.no_scheduled).to eq 50
			end
			it "#media_items" do
				expect(search_output.media_items.length).to eq 20
			end
		end
	end
end
