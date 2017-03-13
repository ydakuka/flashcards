class Dashboard::CardsController < Dashboard::BaseController
  before_action :set_card, only: [:destroy, :edit, :update]

  def index
    @cards = current_user.cards.all.order('review_date')
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
  end

  def flickr_photos_search
    @list_images = Flickr.new(params[:query]).flickr_search

    if @list_image.present?
      respond_to do |format|
        format.js {render layout: false}
      end
    end
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :remove_image, :block_id,
                                 :remote_image_url)
  end
end
