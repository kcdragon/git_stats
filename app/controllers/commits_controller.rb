class CommitsController < ApplicationController
  def index
    @commits = Commit.where(repository_id: params[:repository_id])
  end

  def show
    @commit = Commit.where(id: params[:id],
                           repository_id: params[:repository_id]).first
  end
end
