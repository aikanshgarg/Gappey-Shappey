class ChatroomsChannel < ApplicationCable::Channel
  
  def subscribed
  	current_user.chatrooms.each do |chatroom|
  		stream_from "chatrooms:#{chatroom.id}"
    end
    # stream_from "some_channel"
  end

  def unsubscribed
  	stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end

# the name of this method and data argument passed comes from this channel's chatrooms.coffee, not the original
# this performs the exact same action that our controller's action of create did

  def send_message(data)
    @chatroom = Chatroom.find(data["chatroom_id"])
    message = @chatroom.messages.create(body: data["body"], user: current_user)
    MessageRelayJob.perform_later(message)
    #Rails.logger.info data
  end



end
 