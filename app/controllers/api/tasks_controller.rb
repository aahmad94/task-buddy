class Api::TasksController < ApplicationController
  require 'twilio-ruby'
  def index
    # render json for today's task entries
    @tasks = Task.where(["user_id = ? and created_at >= ?", "#{current_user.id}", "#{Time.zone.now.beginning_of_day}"])
    render :index
  end 
  def create
    @task = Task.new(:user_id => current_user.id, :body => task_params["body"])
    if (@task.save) 
      sms(current_user.id, @task.body)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end 
  end 
  
  private

  def sms(user_id, body)
    account_sid = ENV["TWILIO_SID"] # Account SID from www.twilio.com/user/account
    auth_token = ENV["TWILIO_AUTH_TOKEN"]   # Auth Token from www.twilio.com/user/account
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @client.account.messages.create(
      body: body,
      from: ENV["TWILIO_NUMBER"],
      to: current_user.phone_number
      )
  end

  def task_params
    params.require(:task).permit(:body)
  end

end
