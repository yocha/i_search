require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/media_item/media_item.rb'
describe "insider" do
	describe "media_item" do 
		let(:m) {Insider::Search::SearchOutput.new('clipid:1045548').media_items.first}
		describe "#initialize" do
			it "title" do
				expect(m.title).to eq 'WITNESS: Mission Impossible for the next Pope? '
			end
			it "terms" do
				expect(m.terms.length).to be >=  0
			end
		end
	end
end
