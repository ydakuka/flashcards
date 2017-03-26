# require 'nokogiri'
# require 'open-uri'

class Dashboard::FillingsController < Dashboard::BaseController
  def show
  end

  def new
    @filling = current_user.fillings.build
  end

  def create
    @filling = current_user.fillings.build(filling_params)
    if @filling.save
      doc = Nokogiri::HTML(open(@filling.url))
      doc.search('//table/tbody/tr').each do |row|
        original = row.search(@filling.original_selector).text.downcase
        translated = row.search(@filling.translated_selector).text.downcase
        Card.create(original_text: original, translated_text: translated,
                    user_id: current_user.id, block_id: @filling.block_id)
      end
      redirect_to cards_path
    else
      render :new
    end
  end

  private

  def filling_params
    params.require(:filling).permit(:original_selector, :translated_selector, :block_id, :url)
  end
end


