class EmotionsController < ApplicationController
	respond_to :json
	before_filter :create_repo, except: :new

	def new
		@emotion = Emotion.new
	end

	def create
		@emotion, success, error = @repo.create params[:emotion]
		render_json_show success, error
	end

	def edit
		@emotion, success, error = @repo.find_by_id params[:id]
	end

	def update
		@emotion, success, error = @repo.update params[:emotion]
		render_json_show success, error
	end

	def show
		@emotion, success, error = @repo.find_by_id params[:id]
		render_json_show success, error, 404
	end

	def destroy
		@repo.delete params[:id]
		render json: { message: "Successfully deleted emotion with id #{params[:id]}" }
	end

	def index
		@emotions = @repo.find
	end

	protected

	def create_repo
		@repo = BaseRepository.new current_user
		@repo.klass = Emotion
		@repo
	end

	def render_json_show(success, error, error_status=500)
		if success
			render :show
		else
			render json: { message: error }, status: error_status
		end
	end
end
