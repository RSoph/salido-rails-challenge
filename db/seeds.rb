# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'net/http'

key = Rails.application.secrets.wine_dot_com_key
key = "f7a7b6c3b8b64644540a8a27734576aa"
uri = URI("http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&apikey=#{key}")
response = Net::HTTP.get_response(uri).body
result = JSON.parse(response)
data = result['Products']['List']

data.each do |datum|
  wine = Wine.new(name: datum['Name'], community_rating: datum["Community"]["Reviews"]["HighestScore"])
  wine.vineyard = datum["Vineyard"]["Name"] if datum["Vineyard"]
  wine.description = datum['Description'].split("<")[0] unless datum['Description'].split("<")[0] == ""
  wine.description ||= datum['Description'].split("<")[1][2..-1] if datum['Description'].split("<")[1]
  if wine.description == "- WINE.COM START -->\r\n"
  	wine.description = nil
  end
  wine.save!
end