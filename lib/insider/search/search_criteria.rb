require 'nokogiri'
module Insider
	module Search
		module SearchCriteria
			def self.formatted_output(input = {:includes => [{:text => "channelid:3", :type => 'text'}]}, mode = 'Any', order = 'Date')
				output = Nokogiri::XML::Builder.new do |xml| 
					xml.search_criteria {
						xml.mode mode 
						xml.order order 
						if input[:includes]
							xml.includes {
								input[:includes].each do |input|
									xml.term {
										xml.text_ input[:text] if input[:text]
										xml.type input[:type] if input[:type] 
										xml.id input[:id] if input[:id]
									}
								end
							}
						end
					}
				end
				output.to_xml
			end
		end
	end
end
