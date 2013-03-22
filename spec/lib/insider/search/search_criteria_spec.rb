require_relative '../../../../lib/insider/search/search_criteria.rb'

describe "insider search criteria" do
	describe "input" do
		it "#get_input" do
			input = Insider::Search::SearchCriteria.get_input('spec/fixtures/search_criteria.yaml')
			expect(input[:includes]).to_not eq nil
			expect(input[:mode]).to_not eq nil
			expect(input[:order]).to_not eq nil
			expect(input[:after_date]).to_not eq nil
			expect(input[:before_date]).to_not eq nil
		end
	end
	describe "output simple xml" do
		it "#formatted_output" do
			output = Nokogiri::XML::Builder.new do |xml| 
				xml.search_criteria {
					xml.mode 'Any' 
					xml.order 'Date' 
						xml.includes {
								xml.term {
									xml.text_ 'channelid:3'
									xml.type 'text'
								}
						}
				}
			end
			expect(Insider::Search::SearchCriteria.formatted_output).to eq output.to_xml 
		end
	end
end
