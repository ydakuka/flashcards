module CreatingCard
  extend ActiveSupport::Concern

  included do
    attr_reader :card
  end

  def create_card(params)
    if params[:id]
      @card = current_user.cards.find(params[:id])
    else
      if current_user.current_block
        pending_repeating(current_user.current_block.cards)
      else
        pending_repeating(current_user.cards)
      end
    end
  end

  private

  def pending_repeating(current_card)
    @card = current_card.pending.first || current_card.repeating.first
  end
end
