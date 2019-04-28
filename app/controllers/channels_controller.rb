class ChannelsController < ApplicationController
  def create
    @channel = Channel.new(channel_params)
    authorize! :create, @channel
    if @channel.save
      render :show, status: :created
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  def channel_params
    params.require(:channel).permit(:id, :slug, :user_id, :team_id)
  end
end
