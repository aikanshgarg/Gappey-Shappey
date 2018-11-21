class MessagesController < ApplicationController

	before_action :authenticate_user!
	before_action :set_chatroom

	def create
		message = @chatroom.messages.new(message_params)
		message.user = current_user
		message.save
		

		# we will send this message to the queue which will build a job. Job will later on send it to action cable for all the browsers that are conncted
		MessageRelayJob.perform_later(message)
		
		redirect_to @chatroom
		#nothing's working :( 
		# respond_to do |format|
		#   format.js {render :layout=>false}
		# end
		#respond_to :js
		
		
	end


 private

	def set_chatroom
		@chatroom = Chatroom.find(params[:chatroom_id])
	end

	def message_params
		params.require(:message).permit(:body)
	end


end