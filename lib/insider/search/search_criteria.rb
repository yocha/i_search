require 'nokogiri'
module Insider
	module Search
		module SearchCriteria
			def self.formatted_output(input = {})
				default_input = {:mode => 'Any', :order => 'Date'}
				default_input.merge!(input)
				output = Nokogiri::XML::Builder.new do |xml| 
					xml.search_criteria {
						xml.mode default_input[:mode]
						xml.order default_input[:order] 
						xml.includes {
							default_input[:includes].each do |input|
								xml.term {
									xml.text_ input[:text] if input[:text]
									xml.type input[:type] if input[:type] 
									xml.id input[:id] if input[:id]
								}
							end if default_input[:includes]
						}
						xml.requires {
							default_input[:requires].each do |input|
								xml.term {
									xml.text_ input[:text] if input[:text]
									xml.type input[:type] if input[:type] 
									xml.id input[:id] if input[:id]
								}
							end if default_input[:requires]
						}
						xml.requires_any {
							default_input[:requires_any].each do |input|
								xml.term {
									xml.text_ input[:text] if input[:text]
									xml.type input[:type] if input[:type] 
									xml.id input[:id] if input[:id]
								}
							end if default_input[:requires_any]
						}
						xml.after_date input[:after_date] if default_input[:after_date]
						xml.before_date input[:before_date] if default_input[:before_date]
					}
				end
				output.to_xml
			end
			def self.get_input(filename)
				YAML.load_file(filename)
			end
		end
	end
end
