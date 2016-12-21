class GroupsController < ApplicationController
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :show]
	before_action :check_user_permission, only: [:edit, :update, :destroy]
	def index
		@groups = Group.all
	end

	def new
		@group = Group.new
	end

	def create
		@group = Group.new(group_params)
		@group.user = current_user
		if @group.save
			redirect_to groups_path
			flash[:notice] = "Created Successfully"
		else
			render :edit
		end
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
	end

	def edit
	end

	def update
		if @group.update(group_params)
			redirect_to groups_path
		else
			render :edit
		end
	end

	def destroy
		@group.destroy
		redirect_to groups_path
	end

	private

	def check_user_permission
		@group = Group.find(params[:id])
		if @group.user != current_user
			redirect_to root_path, alert: "You have no permission"
		end
	end

	def group_params
		params.require(:group).permit(:title, :description)
	end

end
