class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find_by(id: params[:id])

    if tutorial
      @facade = TutorialFacade.new(tutorial, params[:video_id])
    else
      flash[:error] = 'Tutorial with given ID does not exist.'
      redirect_to root_path
    end
  end
end
