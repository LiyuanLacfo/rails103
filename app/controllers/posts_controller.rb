class PostsController < ApplicationController
	def new
		@group = Group.find(params[:group_id])
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@group = Group.find(params[:group_id])
		@post.user = current_user
		@post.group = @group
		if @post.save
			redirect_to group_path(@group)
		else
			render :new
		end
	end

	def edit
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
	end

	def update
		@group = Group.find(params[:group_id])
		@post = Post.find(params[:id])
		@post.user = current_user
		@post.group = @group
		if @post.update(post_params)
			redirect_to account_posts_path(@group)
		else
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		flash[:alert] = "Post deleted"
		redirect_to account_posts_path
	end

	private

	def post_params
		params.require(:post).permit(:content)
	end
end
