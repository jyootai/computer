class TopicsController < ApplicationController
  before_action :required_login, except: [:index]
  def new
    @topic = Topic.new
  end

  def index
     @topic = Topic.paginate(page: params[:page], per_page: 10)
  end

  def show
    @topic = Topic.find params[:id]
  end

  def create
    @topic=current_user.topics.create params.require(:topic).permit(:title, :body)
    @topic.user_id=current_user.id
    if @topic.save
      redirect_to root_path
    else
      flash[:danger]= '请填写完整，标题和肉容不能为空'
      render 'new'
    end
       
  end

  def update
  end
end
