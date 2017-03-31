class OpenTokSessionsController < ApplicationController

  before_action :get_session, only: [:show, :destroy]

  def index
    @sessions = OpenTokSession.all
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        token = opentok.generate_token @session.session_id
        render json: {apiKey: Rails.application.secrets.open_tok_key, sessionId: @session.session_id, token: token}
      }
    end
  end

  def new
    @session = OpenTokSession.new
  end

  def create
    @session = OpenTokSession.new(permit_params)
    begin
      session = opentok.create_session
      @session.session_id = session.session_id
    rescue Exception=>e
    end
    if @session.save
      redirect_to root_url, notice: 'Сессия добавлена.'
    else
      render :new
    end
  end

  def destroy
    @session.destroy
    redirect_to root_url, notice: 'Сессия удалена.'
  end

  protected

  def get_session
    @session = OpenTokSession.find(params[:id])
  end

  def permit_params
    params.require(:open_tok_session).permit(:name)
  end

  def opentok
    OpenTok::OpenTok.new Rails.application.secrets.open_tok_key, Rails.application.secrets.open_tok_secret
  end

end