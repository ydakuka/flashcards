class Home::HomeController < Home::BaseController
  include CreatingCard

  def index
    respond_to do |format|
      format.html
      format.js
    end
  end
end
