require './lib/insider.rb'

regions_file = 'resources/2013_03_22/Regions.txt'
markets_file = 'resources/2013_03_22/Markets.txt'
markets = File.open(markets_file).readlines.map {|m| m.chomp}
regions = File.open(regions_file).readlines.map {|r| r.chomp}

output  = File.open('output.txt','w')

markets.each do |market|
	regions.each do |region|
		input = {:includes => [{:text => market, :type => 'marketname'},
                           {:text => region, :type => 'regionname'}], 
							:mode => 'All',
							:after_date => '3/10/2013'}
		input_location = {:includes => [{:text => market, :type => 'marketname'},
												 {:text => region, :type => 'location'}], 
						:mode => 'All',
						:after_date => '3/10/2013'}
		input_all = {:includes => [{:text => region, :type => 'regionname'},
												       {:text => region, :type => 'location'}], 
							   :requires => [{:text => market, :type => 'marketname'}],
								 :mode => 'Any',
								 :after_date => '3/10/2013'}
		search_criteria = Insider::Search::SearchCriteria::formatted_output(input)
		search_criteria_location = Insider::Search::SearchCriteria::formatted_output(input_location)
		search_criteria_all = Insider::Search::SearchCriteria::formatted_output(input_all)
		begin
			result = Insider::Search::search(search_criteria)
			result_location = Insider::Search::search(search_criteria_location)
			result_all = Insider::Search::search(search_criteria_all)
			output <<  market + "\t" + region + "\t" + result.no_ondemand.to_s + "\t" + result_location.no_ondemand.to_s + "\t" + result_all.no_ondemand.to_s + "\n"
		rescue
			puts  market + "\t" + region 
			retry
		end
	end
end
