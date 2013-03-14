require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/media_item/media_item.rb'
describe "insider" do
	describe "media_item" do 
		let(:search_result) {Nokogiri::XML(File.open('spec/fixtures/search_result.xml'))}
		let(:m_xml) {search_result.xpath('//media_items/media_item').first}
		describe "#initialize" do
      let(:m) {Insider::MediaItem.new(m_xml)} 
			it 'id' do
				expect(m.id).to eq 1044388
			end
			it "title" do
				expect(m.title).to eq 'Techquity: More concerns about Apple, more praise for Google'
			end
			it 'company_channel_id' do
				expect(m.company_channel_id).to eq 1
			end
			it 'group_channel_id' do
				expect(m.group_channel_id).to eq 3
			end
			it 'owner' do
				expect(m.owner).to eq 'Thomson Reuters'
			end
			it "type" do
				expect(m.type).to eq 'Ondemand'
			end
			it "visibility" do
				expect(m.visibility).to eq 'Public'
			end
			it "live" do
				expect(m.live).to eq false
			end
			it "publish date" do
				expect(m.publish_date).to eq '03/11/2013 18:00:00'
			end
			it "duration" do
				expect(m.duration).to eq 166
			end
			it "terms" do
				expect(m.terms.length).to be >=  0
			end
		end
	end
end
