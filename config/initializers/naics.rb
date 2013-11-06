NAICS_CODES = Rails.cache.read('naics_codes')
if Rails.env != 'test'
	unless NAICS_CODES
	    naics_full = HTTParty.get(URI.encode('http://api.naics.us/v0/q?year=2012'))
	    # the API query also returns parent nodes. we want only the actual 6 digit NAICS codes.
	    naics_six_digit = naics_full.select{|n| n['code'].to_s.length == 6 }.map{|n| n.slice('code', 'title', 'description')}
	    Rails.cache.write('naics_codes', naics_six_digit)
	    NAICS_CODES = naics_six_digit
	end
else
	NAICS_CODES = []
end