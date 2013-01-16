class CommentsController < ApplicationController
	respond_to :html, :js

 		before_filter (:only => [:create ] ) { |c| c.auth  nil }
 		before_filter(:only => [:destroy ] ) { |c| c.auth  [ {:types =>  [User::READER] , :condition => lambda{|params,session| Comment.find(params[:id]).user_id == session[:userid]} } , {:types => [User::ADMIN, User::BLOGGER]} ]  }


  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
		@comment.user_id = session[:userid]
     @comment.save
		respond_with @comment, :location => @comment.post
  end


  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

		respond_with @comment, :location => @comment.post
  end
end
