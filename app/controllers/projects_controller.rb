class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Project has been updated."
      redirect_to @project
    else
      flash[:alert] = "Project has not been updated."
      render "edit"
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project has been destroyed."

    redirect_to projects_path
  end

  private
    def set_project
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The project you were looking for could not be found."
      redirect_to projects_path
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
