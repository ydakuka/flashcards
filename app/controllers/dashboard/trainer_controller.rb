class Dashboard::TrainerController < Dashboard::BaseController
  include CreatingCard

  def index
    create_card(params)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def review_card
    @card = current_user.cards.find(params[:card_id])
    check_result(@card)
    ahoy.track "card:reviewed", card_id: @card.id
  end

  private

  def trainer_params
    params.permit(:user_translation)
  end

  def check_result(card)
    result = card.check_translation(trainer_params[:user_translation])

    if result[:state]
      if result[:distance].zero?
        flash[:notice] = t(:correct_translation_notice)
      else
        flash[:alert] = t 'translation_from_misprint_alert',
                          user_translation: trainer_params[:user_translation],
                          original_text: card.original_text,
                          translated_text: card.translated_text
      end
      redirect_to trainer_path
    else
      flash[:alert] = t(:incorrect_translation_alert)
      redirect_to trainer_path(id: card.id)
    end
  end
end
