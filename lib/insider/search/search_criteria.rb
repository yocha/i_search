require 'nokogiri'
module Insider
	module Search
		module SearchCriteria
			def self.formatted_output(input)
				output = Nokogiri::XML::Builder.new do |xml| 
					xml.search_criteria {
						xml.mode 'Any'
						xml.order 'Date'
						xml.includes {
							xml.term {
							  xml.text "Obama"
								xml.type "text"
							}
						}
					}
				end
				output.to_xml
			end
		end
	end
end
