class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find_by(id: params[:id])

    if tutorial
      if !tutorial.classroom || (current_user && tutorial.classroom)
        @facade = TutorialFacade.new(tutorial, params[:video_id])
      else
        classroom_content_error
      end
    else
      tutorial_not_found_error
    end
  end

  private

  def classroom_content_error
    flash[:error] = 'Please login to view classroom content tutorials.'
    redirect_to root_path
  end

  def tutorial_not_found_error
    flash[:error] = 'Tutorial with given ID does not exist.'
    redirect_to root_path
  end
end
