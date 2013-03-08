module Insider
	class Term
		attr_accessor :term, :manual, :source, :token_id,
			            :rank, :relevancy,
									:tmc_id,
									:ric,
									:term_type,
									:count,
									:ticker,
									:passage_no
		def initialize(t)
			raise 'error' unless t.class == Nokogiri::XML::Element
			@term = t.text
			@manual = t.attributes['manual'].text
			@source = t.attributes['source'].text
			@source = t.attributes['token_id'].text.to_i
			@rank = t.attributes['rank'].text
			@relevancy = t.attributes['relevancy'].text
			@tmc_id = t.attributes['tmc_id'].text.to_i
			@ric = t.attributes['ric'].text
			@term_type = t.attributes['term_type'].text
			@count = t.attributes['count'].text.to_i
			@ticker = t.attributes['ticker'].text
			@passage_no = t.attributes['passage_no'].text
		end
	end
end
