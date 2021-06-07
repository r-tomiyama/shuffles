class ShuffleListsController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create]

  def index
    @shuffle_lists = current_user.shuffle_lists if logged_in?
  end

  def create
    @shuffle_list = current_user.shuffle_lists.build(name: shuffle_list_params[:list_name])
    items = shuffle_list_params[:item_name].split(',')
    items.each { |item| @shuffle_list.shuffle_items.build(name: item) }
    # TODO: 以下のように簡潔にかけるようにしたい
    # @shuffle_list = current_user.shuffle_lists.build(shuffle_list_params)
    if @shuffle_list.save
      flash[:success] = 'リストを登録しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'リストの登録に失敗しました' # TODO: 失敗時のメッセージを表示したい
      render action: :index # TODO: 元々の@shuffle_listsを表示できるようにしたい
    end
  end

  # TOOD: edit
  # TODO: delete

  def execute
    # TODO: リフレッシュ時にエラーにならないようにする
    items = ShuffleList.find(execute_params[:id])&.shuffle_items
    if items && !items.empty?
      @result = items.sample
      @others = items.reject { |item| item == @result }
      flash[:success] = 'シャッフルしました'
    else
      flash.now[:danger] = 'シャッフルに失敗しました'
    end
  end

  private

  def shuffle_list_params
    params.permit(:list_name, :item_name)
  end

  def execute_params
    params.permit(:id)
  end
end
