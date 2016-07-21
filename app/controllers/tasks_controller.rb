class TasksController < ApplicationController
  before_action :set_list , only: [:new, :create, :show, :edit, :update,:destroy]
  before_action :set_task, only: [ :show, :edit, :update,:destroy]
  before_action :check_admin , only: [:new, :destroy]
  before_action :downcase_strip_title, only: [:create]
  

def index
  @tasks = Task.all
end

def userindex
  @tasks = current_user.tasks
    respond_to do |format|
      format.html { render :userindex  }
      format.json {render json: @tasks}
    end
  end

def new
  @task = @list.tasks.build
end

def create
  @task = @list.tasks.build(admin_task_params)
  if @task.save
    flash[:success] = "Task created"
    render json: @task, status: 201
    #redirect_to @list
  else
    render :new
  end
end

def show
  respond_to do |format|
      format.html { render :show  }
      format.json {render json: @task}
    end
end

def completed
  @tasks = current_user.completed_tasks
  render :index,  :locals => {:my_string=>"My Completed"}
end

def overdue
  @tasks = current_user.overdue_tasks
  render :index,:locals => {:my_string=>"My Overdue"}
end


def edit
end

def update
  if current_user.admin?
    @task.update(admin_task_params)
    redirect_to @list
    else
      verify_valid_fields
  end
end

def destroy
  @task = @list.tasks.find(params[:id])
  @task.destroy
  flash[:success] = "Task deleted"
  redirect_to list_path (@list)
end



  private
  def admin_task_params
    params.require(:task).permit(:title, :description, :status, :due_date, :user_id)
  end

  def user_task_params
    params.require(:task).permit(:status, :user_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = @list.tasks.find(params[:id])
  end

  def downcase_strip_title
    params[:task][:title] = params[:task][:title].strip.downcase
  end

  def verify_valid_fields
    if !@task.user.nil? && @task.user != current_user
          flash[:danger] = "You can only edit tasks assigned to you"
          redirect_to edit_list_task_path(@list,@task) and return
    elsif params[:task][:user_id].to_i != current_user.id
          flash[:danger] = "You can only assign tasks to yourself"
          redirect_to edit_list_task_path(@list,@task) and return
    else
          @task.update(user_task_params)
         redirect_to @list
    end
  end

  def check_admin
    if !current_user.admin?
      flash[:danger] = "Only Admins can add/delete Tasks"
      redirect_to @list
    end
  end
end
