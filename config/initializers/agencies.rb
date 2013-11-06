#Rails.cache.clear
AGENCIES = Rails.cache.read('agency_list')

if Rails.env != 'test'
	unless AGENCIES
	    agency_tree = HTTParty.get(URI.encode('http://www.usa.gov/api/USAGovAPI/contacts.json/contacts?result_filter=Id|Name|parent|synonym|language&sort=name&query_filter=language::en'), headers: {'Content-Type' => 'application/json'})
	    agency_names = agency_tree['Contact'].map{|c| c['Name']}.sort()
	    Rails.cache.write('agency_list', agency_names)
	    AGENCIES = agency_names
	end
else
	AGENCIES = []
end