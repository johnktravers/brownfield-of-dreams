class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.new(new_tutorial_params)

    if @tutorial.save
      redirect_to tutorial_path(@tutorial.id),
                  success: 'Tutorial was successfully created'
    else
      flash.now[:error] = @tutorial.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(update_tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    tutorial.destroy

    redirect_to admin_dashboard_path
  end

  private

  def update_tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def new_tutorial_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
