class GamesController < ApplicationController
	def index
		@games = Game.all
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
