require 'zlib'
require 'open-uri'

namespace :georedirect do
  DB_URI = 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'

  desc "Fetches an updated copy of the GeoIP countries DB from MaxMind"
  task :fetch_db do
    # Fetches DB copy and gunzips it
    # Thx http://stackoverflow.com/a/2014317/107085
    source = open(DB_URI)
    gz = Zlib::GzipReader.new(source)
    result = gz.read

    # Write to file
    filename = Rails.root.join('db', 'GeoIP.dat')
    File.open(filename, 'w') { |f| f.write(result) }
  end
end
