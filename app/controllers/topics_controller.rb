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
    @topic=current_user.topics.create params.require(:topic).permit(:title, :body)
    @topic.user_id=current_user.id
    if @topic.save
      redirect_to @topic
    else
      flash.now[:danger]= I18n.t('topics.flashes.failed_post')
      render 'new'
    end
       
  end

  def update
  end

  private
    def find_topic
      @topic=current_user.topics.find params[:id]
    end
end
