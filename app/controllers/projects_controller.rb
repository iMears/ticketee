class ProjectsController < ApplicationController
  def index

  end

  def new
    @project = Project.new
  end

  def create
    p params
    @project = Project.new(project_params)

    if @project.save
      # Many ways to set flash message

      # First way: set flash message and redirect separately
      # flash[:notice] = "Project has been created."
      # redirect_to @project

      # Second way: pass notice: or alert: as a second parameter to redirect_to
      # redirect_to @project, notice: "Project has been created."
      # redirect_to @project, alert: "Project has been created."

      # Third way: If you do not wish to use either notice or alert, you must specify flash as a hash:
      redirect_to @project, flash: { success: "Project has been created." }
    else
      flash[:alert] = "Project has not been created."
      render "new"
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
