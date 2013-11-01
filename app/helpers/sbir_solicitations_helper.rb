module SbirSolicitationsHelper
  def fbopen_listing_link(id)
    base_url = ENV['FBOPEN_URI']
    base_url += "?q=id:#{id}"
  end
end
