class Admin::TopicsController < Admin::ApplicationController
  before_action :find_topic, only: [:show, :update, :trash, :restore]

  def index
    @topics = Topic.order(id: :desc).page(params[:page])
  end

  def show
  end

  def trashed
    @topics = Topic.trashed.order(id: :desc).page(params[:page])
    render :index
  end
  
  def update
    if @topic.update_attributes params.require(:topic).permit(:title, :category_id, :body)
      flash[:success]= I18n.t('settings.flashes.successfully_updated_topic')
      redirect_to admin_topic_url(@topic)
    else
      render :show
    end
  end

  def trash
    @topic.trash
    flash[:success] =  I18n.t('settings.flashes.successfully_trashed_topic')
    redirect_to admin_topic_path(@topic)
  end

  def restore
    @topic.restore
    flash[:success] = I18n.t('settings.flashes.successfully_restored_topic')
    redirect_to admin_topic_path(@topic)
  end

  private
   
    def find_topic
      @topic = Topic.with_trashed.find params[:id]
    end

end
