class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  # Devise helper, authenticate before allowing these actions from wi
  # thin the controller. Except is opposite of only 
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]


  # Devise Helper : current_user
  # GET /tasks
  # GET /tasks.json
  # If there are no view loading or additional
  # commands, will automatically load views/tasks/index.html.erb
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
  # No need to pass params here
  @task = current_user.tasks.build
  #  @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    # Passes the attributes, but user_id also gets passed
    @task = current_user.tasks.build(task_params)
    # @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :due, :priority, :image)
    end

    # Helper method correct user
    def correct_user
      # This line raises an error by default if record is not found. user alt
      # @task = current_user.tasks.find(params[:id])
      if current_user.nil?
        redirect_to new_user_session_path, notice: "Login or Signup to edit tasks"
      else        
      @task = current_user.tasks.find_by(id: params[:id])
        if @task.nil?
          redirect_to tasks_path, notice: "Not authorized to edit this task" 
          # Alt syntax
          # flash[:notice] = "Message"     
        end
      end      
    end
end
