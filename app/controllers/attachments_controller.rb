class AttachmentsController < ApplicationController
  before_action :required_login

  def create
     @attachment = current_user.attachments.create params.require(:attachment).permit(:file)
     render json: { url: @attachment.file.url }
  end
end
