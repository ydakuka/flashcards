# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.learnathome.ru/blog/100-beautiful-words'))

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]/p')[0].content.downcase
  translated = row.search('td[1]/p')[0].content.downcase
  Card.create(original_text: original, translated_text: translated, user_id: 17)
end