# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).

# Seeds to fill the cards table
require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('http://www.learnathome.ru/blog/100-beautiful-words'))

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td[2]/p')[0].content.downcase
  translated = row.search('td[1]/p')[0].content.downcase
  Card.create(original_text: original, translated_text: translated, user_id: 17)
end

# Seeds for add user with admin role
Role.where(name: :admin).first_or_create
admin_user = User.find_or_create_by(email: 'admin@gmail.com') do |user|
  user.password = 'supermegapassword'
  user.password_confirmation = 'supermegapassword'
end
admin_user.add_role(:admin)
