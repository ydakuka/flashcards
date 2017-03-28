FactoryGirl.define do
  factory :filling do
    original_selector   'td[4]'
    translated_selector 'td[2]'
    url 'https://www.learnathome.ru/blog/100-beautiful-words'
    block
    user
  end
end
