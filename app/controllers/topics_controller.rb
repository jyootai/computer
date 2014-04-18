class TopicsController < ApplicationController
  before_action :required_login, except: [:index,:show]
  before_action :find_topic, only: [:edit, :update]
  def new
    @topic = Topic.new
  end

  def index
  #   @topic = Topic.paginate(page: params[:page], per_page: 10)
    @topics = Topic.order(id: :desc).page params[:page]
  end

  def show
    @topic = Topic.find params[:id]
    @comments=@topic.comments.includes(:user).order(id: :asc).page params[:page]
    respond_to do |format|
      format.html
    end

  end

  def create
    @topic=current_user.topics.create topic_params
    @topic.user_id=current_user.id
    if !@topic.save
      flash.now[:danger]= I18n.t('topics.flashes.failed_post')
      render 'new'
    end
       
  end

  def update
     @topic.update_attributes topic_params
  end

  def trash
     @topic = Topic.find(params[:id])
     @topic.destroy_by(current_user)
     redirect_to root_path
  end

  private
    def find_topic
      @topic=current_user.topics.find params[:id]
    end

    def topic_params
      params.require(:topic).permit(:title,:body)
    end
end
