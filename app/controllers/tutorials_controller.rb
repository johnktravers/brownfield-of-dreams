class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find_by(id: params[:id])

    if tutorial
      if !tutorial.classroom || (current_user && tutorial.classroom)
        @facade = TutorialFacade.new(tutorial, params[:video_id])
      else
        flash[:error] = 'Please login to view classroom content tutorials.'
        redirect_to root_path
      end
    else
      flash[:error] = 'Tutorial with given ID does not exist.'
      redirect_to root_path
    end
  end

end
