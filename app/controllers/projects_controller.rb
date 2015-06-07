class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
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

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    flash[:notice] = "Project has been destroyed."

    redirect_to projects_path
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
