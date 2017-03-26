class Dashboard::FillingsController < Dashboard::BaseController
  def show
    filling_result = FillingResult.where(job_id: params[:id])
    @cards         = Card.where(id: filling_result)
  end

  def new
    @filling = current_user.fillings.build
  end

  def create
    @filling = current_user.fillings.build(filling_params)
    respond_to do |format| 
      if @filling.save 
        RemoteFillingJob.perform_later @filling.id, current_user.id
        format.html { redirect_to @filling, notice: 'Filling was successfully created.' }    
      else 
        format.html { render :new } 
      end 
    end 
  end

  private

  def filling_params
    params.require(:filling).permit(:original_selector, :translated_selector, :block_id, :url)
  end
end
