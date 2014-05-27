class Admin::CommentsController < Admin::ApplicationController
  before_action :find_comment, except: [:index, :trashed]
  
  def index
    @comments = Comment.order(id: :desc).page(params[:page])
  end

  def show
  end

  def update
    if @comment.update_attributes params.require(:comment).permit(:body)
      flash[:success] = I18n.t('settings.flashes.successfully_updated_comment')
      redirect_to admin_commnet_path(@comment)
    else
      render :show
    end
  end

  def trash
    @comment.trash
    flash[:success] = I18n.t('settings.flashes.successfully_trashed_comment')
    redirect_to admin_comment_path(@comment)
  end

  def restore
    @comment.restore
    flash[:success] =  I18n.t('settings.flashes.successfully_restored_comment')
    redirect_to admin_comment_path(@comment)
  end

  def trashed
    @comments = Comment.trashed.order(id: :desc).page(params[:page])
    render :index
  end


  private
    
    def find_comment
      @comment = Comment.with_trashed.find params[:id]
    end
end
