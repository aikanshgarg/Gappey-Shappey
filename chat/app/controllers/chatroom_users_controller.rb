# this controller acts only for the current user and kind of acts a join between users and chatrooms in the database

class ChatroomUsersController < ApplicationController

	before_action :authenticate_user!

	before_action :set_chatroom

	# To join a chatroom
	def create
		@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create

		redirect_to @chatroom
	end

	# To leave a chatroom
	# destroy_all is good for seamless UX/UI : even if a user accidently clicks Leave on a chatroom he wasn't in, the program won't crash 
	def destroy
		@chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
		redirect_to chatrooms_path
	end



	private
	def set_chatroom
		@chatroom = Chatroom.find(params[:chatroom_id])
	end


end