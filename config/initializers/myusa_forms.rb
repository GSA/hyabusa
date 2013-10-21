# throw any MyUSA form schemas we might need in memcached
# TODO: this code for caching things, along with the NAICS initializer,
#  could probably be abstracted...

key = 'myusa_forms_sf424'

Rails.cache.clear
MYUSA_FORMS ||= {}
MYUSA_FORMS['SF-424'] = Rails.cache.fetch(key)

unless MYUSA_FORMS['SF-424']
  #TODO: move forms service root url out to a config
  myusa_forms_url = 'http://staging.forms.my.usa.gov'
  sf_424 = HTTParty.get(URI.encode("#{myusa_forms_url}/api/forms/SF-424.json")).parsed_response
  Rails.cache.write(key, sf_424)
  MYUSA_FORMS['SF-424'] = sf_424
end
