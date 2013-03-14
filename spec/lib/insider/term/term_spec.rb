require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/media_item/media_item.rb'
describe "insider" do
	describe "media_item" do 
		let(:search_result) {Nokogiri::XML(File.open('spec/fixtures/search_result.xml'))}
		let(:m_xml) {search_result.xpath('//media_items/media_item').first}
		let(:m) {Insider::MediaItem.new(m_xml)} 
		describe "#initialize" do
			let(:terms) {m.terms}
		  let(:term) {terms.first}	
			it 'term' do
				expect(term.term).to eq 'Apple Inc'
			end
			it 'ric' do
				expect(term.ric).to eq 'AAPL.O'
			end
			it 'ticker' do
				expect(term.ticker).to eq 'AAPL'
			end
		end
	end
end
