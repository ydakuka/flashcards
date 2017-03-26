class Dashboard::FillingsController < Dashboard::BaseController
  def index
  end

  def new
    @filling = current_user.fillings.build
  end

  def create
    @filling = current_user.fillings.build(filling_params)
    if @filling.save
      RemoteFillingJob.perform_later @filling.id, current_user.id
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
