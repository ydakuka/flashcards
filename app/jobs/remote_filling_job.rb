class RemoteFillingJob < ApplicationJob
  queue_as :default

  def perform(filling_id, user_id)
    filling = Filling.find filling_id
    doc = Nokogiri::HTML(open(filling.url))
    doc.search('//table/tbody/tr').each do |row|
      original   = row.search(filling.original_selector).text.downcase
      translated = row.search(filling.translated_selector).text.downcase
      card = Card.create(original_text: original, translated_text: translated,
                        user_id: user_id, block_id: filling.block_id)
      FillingResult.create(job_id: filling.id, card_id: card.id)
    end
    count = FillingResult.count
  end
end
