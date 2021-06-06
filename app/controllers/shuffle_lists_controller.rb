class ShuffleListsController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create]

  def index
    @shuffle_lists = current_user.shuffle_lists if logged_in?
  end

  def create
    @shuffle_list = current_user.shuffle_lists.build(shuffle_list_params)
    if @shuffle_list.save
      flash[:success] = 'リストを登録しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'リストの登録に失敗しました' # TODO: 失敗時のメッセージを表示したい
      render action: :index # TODO: 元々の@shuffle_listsを表示できるようにしたい
    end
  end

  private

  def shuffle_list_params
    params.require(:shuffle_list).permit(:name)
  end
end
