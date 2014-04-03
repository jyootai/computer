class CommentsController < ApplicationController
  before_action :required_login
  before_action :find_comment, only: [:edit, :update ]
  
  def create
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
    @comment = @commentable.comments.create params.require(:comment).permit(:body).merge(user: current_user)
  end

  private

    def find_comment
      @comment= current_user.comments.find params[:id]
    end
end
