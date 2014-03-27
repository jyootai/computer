class TopicsController < ApplicationController
  before_action :required_login
  def new
    @topic = Topic.new
  end

  def index
  end

  def show
  end

  def create
    @topic=current_user.topics.creats params.require(:topic).permit(:title, :body)
    @topic.user_id=current_user.id
    if @topic.save
      flash[:success]= '成功创建新帖'
      redirct_ro topic_path
    else
      render 'new'
    end
       
  end

  def update
  end
end
