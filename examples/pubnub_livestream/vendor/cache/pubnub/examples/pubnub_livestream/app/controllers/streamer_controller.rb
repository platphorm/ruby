class StreamerController < ApplicationController
  before_filter :subscribe, :only => :index

  def index
  end

  def publish
    render :json => $pubnub.publish(
        :channel => 'pubnub_chat',
        :callback => lambda {|x|},
        :message => {
            :author => params[:author],
            :message => params[:message]

        }
    )
  end

  def get_messages
    render :json => Message.all
  end

  private

  def subscribe
    $pubnub.subscribe(
        :channel => 'pubnub_chat',
        :callback => $callback
    ) unless $pubnub.subscription_running?
  end

end
