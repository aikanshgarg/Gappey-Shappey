class MessageRelayJob < ApplicationJob
  queue_as :default

  # This job takes message as argument and we pass two things in the hash that are message itself and the chatroom_id. 
  
  # chatroom_id is passed for using UI things like displaying a green dot on new messages in the room which we are not currently in!
  # MessageController.render(message) automatically render the partial called message. So, be sure to make it under messages view folder!

  def perform(message)
  	ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
  		message: MessagesController.render(message),
  		chatroom_id: message.chatroom.id
  	}
    # Do something later
  end
end
