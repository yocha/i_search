require_relative '../term/term.rb'
module Insider
	class MediaItem
		attr_accessor :id, :title, :description, :type, :publish_date
		attr_accessor :visibility, :live
		attr_accessor :company_channel_id, 
			            :group_channel_id,
									:sources,
									:owner,
									:duration,
									:terms
		def initialize(m)
			raise 'error' unless m.class == Nokogiri::XML::Element
			@id = m.attributes['id'].text.to_i
			@title = m.at('name').text
			@description = m.at('description').text
			@company_channel_id = m.at('company_channel_id').text.to_i
			@group_channel_id = m.at('group_channel_id').text.to_i
			@owner = m.at('owner').text
			@type = m.at('type').text
			@visibility = m.attributes['visibility'].text
			@live =  m.at('live').text.downcase == 'true'
			@publish_date = m.at('publish_date').text
			@duration = m.at('duration').text.to_i
			@terms = m.xpath('terms').xpath('term').map {|t| Insider::Term.new(t)}
		end
	end
end
