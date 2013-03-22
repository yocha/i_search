require_relative '../../../../lib/insider/search/search.rb'
require_relative '../../../../lib/insider/search/search_output.rb'
require_relative '../../../../lib/insider/search/search_criteria.rb'
describe "insider search" do
	describe "search" do
		describe "for eikon" do
			let(:eikon_input)  {Insider::Search::SearchCriteria::get_input('spec/fixtures/eikon_search.yml')}
			let(:search_criteria) {Insider::Search::SearchCriteria::formatted_output(eikon_input)}
			it "first eikon search" do
				puts search_criteria
				result = Insider::Search::search(search_criteria, {:type_filter => 'ondemand'})
				puts result.search_criteria
				puts result.no_ondemand
				puts result.no_scheduled
				expect(result.class).to eq Insider::Search::SearchOutput
				expect(result.media_items.length).to be > 0
				puts result.media_items.first.id
				puts result.media_items.first.publish_date
				puts result.media_items.last.id
			end

		end
	end
end
