class ShuffleListsController < ApplicationController
  before_action :require_user_logged_in, only: %i[index create]

  def index
    @shuffle_lists = current_user.shuffle_lists if logged_in?
  end

  def create
    @shuffle_list = current_user.shuffle_lists.build(name: create_shuffle_list_params[:list_name])
    items = create_shuffle_list_params[:item_name].split(',')
    items.each { |item| @shuffle_list.shuffle_items.build(name: item) }
    # TODO: 以下のように簡潔にかけるようにしたい
    # @shuffle_list = current_user.shuffle_lists.build(create_shuffle_list_params)
    if @shuffle_list.save
      flash[:success] = 'リストを登録しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'リストの登録に失敗しました'
      render action: :index # TODO: 元々の@shuffle_listsを表示できるようにしたい
    end
  end

  def edit
    @errors = shuffle_list_params[:errors]&.split(',')
    shuffle_list = ShuffleList.find(shuffle_list_params[:id])
    @list_name = shuffle_list.name
    @item_name = shuffle_list.shuffle_items.map(&:name).join(',')
  end

  def update
    shuffle_list = ShuffleList.find(shuffle_list_params[:id])
    old_items = shuffle_list.shuffle_items.map(&:name)

    shuffle_list.assign_attributes(name: create_shuffle_list_params[:list_name])
    shuffle_list.shuffle_items.delete_all
    items = create_shuffle_list_params[:item_name].split(',')
    items.each { |item| shuffle_list.shuffle_items.build(name: item) }

    if shuffle_list.valid?
      shuffle_list.save
      flash[:success] = 'リストを更新しました'
      redirect_to root_url
    else
      old_list = shuffle_list.dup
      errors = shuffle_list.errors.full_messages

      shuffle_list.reload
      old_items.each { |item| shuffle_list.shuffle_items.build(name: item) }
      shuffle_list.save

      flash[:danger] = 'リストの更新に失敗しました'
      redirect_to action: :edit, errors: errors.join(',')
    end
  end

  def destroy
    shuffle_list = ShuffleList.find(shuffle_list_params[:id])
    shuffle_list.destroy
    redirect_to root_url
  end

  def execute
    # TODO: リフレッシュ時にエラーにならないようにする
    items = ShuffleList.find(shuffle_list_params[:id])&.shuffle_items
    if items && !items.empty?
      @result = items.sample
      @others = items.reject { |item| item == @result }
      flash[:success] = 'シャッフルしました'
    else
      flash.now[:danger] = 'シャッフルに失敗しました'
    end
  end

  private

  def create_shuffle_list_params
    params.permit(:list_name, :item_name)
  end

  def shuffle_list_params
    params.permit(:id, :errors)
  end
end
