# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

key = Rails.application.secrets.wine_dot_com_key
uri = URI("http://services.wine.com/api/beta2/service.svc/json/catalog?size=100&apikey=#{key}")
response = Net::HTTP.get_response(uri).body
result = JSON.parse(response)
data = result['Products']['List']

data.each do |datum|
  Wine.create(name: datum['Name'], description: datum['Description'], vineyard: datum["Vineyard"], community_rating: datum["Community"]["Reviews"]["HighestScore"])
end