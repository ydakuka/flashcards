# For more information about the flickr please visit the website: http://www.flickr.com/services/api/

require 'flickraw'

class Flickr
  attr_reader :query, :page, :per_page, :privacy_filter, :flickr

  def initialize(query, page = 1, per_page = 10, privacy_filter = 1)
    @query          = query
    @page           = page
    @per_page       = per_page
    @privacy_filter = privacy_filter
    api_key         = ENV["FLICKR_KEY"]
    shared_secret   = ENV["FLICKR_SECRET"]

    @flickr = FlickRaw::Flickr.new(api_key: api_key, shared_secret: shared_secret)
  end

  def flickr_search
    Rails.cache.fetch("flickr_search/#{query}", expires_in: 6.hours) do
      flickr.photos.search page: page, per_page: per_page, text: query,
                           tags: query, privacy_filter: privacy_filter
    end
  end
end
