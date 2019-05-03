class ChannelsController < ApplicationController
  before_action :set_channel, only: [:destroy, :show]

  def create
    @channel = Channel.new(channel_params)
    authorize! :create, @channel
    if @channel.save
      render :show, status: :created
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  def show
    authorize! :read, @channel
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:id, :slug, :user_id, :team_id)
  end
end
