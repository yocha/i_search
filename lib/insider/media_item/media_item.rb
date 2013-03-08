require_relative '../term/term.rb'
module Insider
	class MediaItem
		attr_accessor :id, :title, :description, :publish_date, :terms
		def initialize(m)
			raise 'error' unless m.class == Nokogiri::XML::Element
			@id = m.attributes['id'].text.to_i
			@title = m.at('name').text
			@description = m.at('description').text
			@publish_date = m.attributes['publish_date']
			@terms = m.xpath('terms').xpath('term').map {|t| Insider::Term.new(t)}
		end
	end
end
