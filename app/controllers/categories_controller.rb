class CategoriesController < ApplicationController
	respond_to :json
	before_filter :create_repo, except: :new

	def new
		@category = Category.new
	end

	def create
		@category, success, error = @repo.create params[:category]
		render_json_show success, error
	end

	def edit
		@category, success, error = @repo.find_by_id params[:id]
	end

	def update
		@category, success, error = @repo.update params[:category]
		render_json_show success, error
	end

	def show
		@category, success, error = @repo.find_by_id params[:id]
		render_json_show success, error, 404
	end

	def destroy
		@repo.delete params[:id]
		render json: { message: "Successfully deleted category with id #{params[:id]}" }
	end

	def index
		@categories, success, error = @repo.find
	end

	protected

	def create_repo
		@repo = BaseRepository.new current_user
		@repo.klass = Category
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

