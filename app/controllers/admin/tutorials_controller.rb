class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def new
    @tutorial = Tutorial.new
  end

  def create
    @tutorial = Tutorial.create(tutorial_params)

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
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def tutorial_params
    params.require(:tutorial).permit(:tag_list, :title, :description, :thumbnail)
  end
end
