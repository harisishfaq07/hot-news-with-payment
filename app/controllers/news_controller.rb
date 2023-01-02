class NewsController < ApplicationController
before_action :verify_payment! 
def new
@new = News.new
end

def create
    @new = News.new(params_news)
    @new.user_id = current_user.id
    @new.save
    redirect_to landpage_path
end

private
def params_news
    params.require(:news).permit(:title , :description)
end
end