class RepositoriesController < ApplicationController
  def index
    @repositories = Repository.all
  end

  def show
    @repository = Repository.find(params[:id])
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = Repository.new(params)

    if @repository.save
      flash[:success] = "#{@repository.path} has been successfully loaded."
      render :index
    else
      render :new
    end
  end
end
