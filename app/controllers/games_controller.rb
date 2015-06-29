class GamesController < ApplicationController
	before_filter :add_allow_credentials_headers

def add_allow_credentials_headers
  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5
  #
  # Because we want our front-end to send cookies to allow the API to be authenticated
  # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so
  # the browser will not reject the response
  response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
  response.headers['Access-Control-Allow-Credentials'] = 'true'
end

def options
  head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'
end

	def index
		@games = Game.all

		respond_to do |format|
			format.html # index.html.erb
			format.any(:xml, :json) { render request.format.to_sym => @games }
		end
	end

  def new
	@game = Game.new
	end

	def create
		@game = Game.new(params[:game].permit!)

		if @game.save
			redirect_to @game
		else
			render 'new'
		end
	end

	def show
		@game = Game.find(params[:id])
		respond_to do |format|
			format.html # index.html.erb
			format.any(:xml, :json) { render request.format.to_sym => @game }
		end
	end


	def game_params
		params.require(:game).permit!
	end
	private :game_params

	def edit
		@game = Game.find(params[:id])
	end

	def update
		@game = Game.find(params[:id])

	  if @game.update(params[:game].permit!)
		redirect_to @game
	  else
		render 'edit'
	  end
	end

	def destroy
	  @game = Game.find(params[:id])
	  @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
	end

end
