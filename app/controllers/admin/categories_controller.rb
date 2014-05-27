class Admin::CategoriesController < Admin::ApplicationController
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories=Category.order(topics_count: :desc)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
       flash[:success] = I18n.t('settings.flashes.successfully_created_node')
       redirect_to admin_category_path(@category)    
     else
       render :new
     end
  end

  def destroy
    @category.destroy
    flash[:success] = I18n.t('settings.flashes.successfully_destroied_node')
    redirect_to admin_categories_path
  end
	

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end
   
    def find_category
      @category = Category.find params[:id]
     end
end
