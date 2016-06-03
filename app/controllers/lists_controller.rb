class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :destroy]
 

  def index
    @lists = List.all
  end

  def userindex
    @lists = current_user.lists
  end

  
 def new
  @list = List.new
  @list.tasks.build
 end

 def create
  @list = List.new(list_params)
  if @list.save
    flash[:success] = "List created"
    redirect_to lists_path
  else
    render :new
  end
 end

def show
end

def edit
end

  def update
    @list.update(list_params)
    redirect_to lists_path
  end


def destroy
  @list.destroy
  flash[:success] = "List deleted"
  redirect_to lists_path
end



private

def list_params
    params.require(:list).permit(:title, tasks_attributes:[:title, :description, :status, :due_date,:user_id])
  end

def set_list
   @list = List.find(params[:id])
 end

 def admin_user
  if !current_user.admin?
  flash[:danger] = "Only Admins can add Lists"
  redirect_to lists_path
end
end
  
end
