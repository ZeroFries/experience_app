class ExperiencesController < ApplicationController
	include ExperiencesHelper
	respond_to :html, :json, only: [:create, :update, :show, :destroy, :index]
	respond_to :html, only: [:new, :edit]
	before_filter :create_repo, except: :new

	def new
		@experience = Experience.new
	end

	def create
		@experience, success, error = @repo.create params[:experience]
		render_json_show success, error
	end

	def edit
		@experience, success, error = @repo.find_by_id params[:id]
	end

	def update
	end

	def show
		@experience, success, error = @repo.find_by_id params[:id]
		render_json_show success, error, 404
	end

	def destroy
	end

	def index
		@experiences = @repo.search params[:filters]
		# render json: { experiences: sort_by_most_recently_popular(@experiences) }	
	end

	protected

	def create_repo
		@repo = ExperienceRepository.new current_user, belongs_to_user: true
	end

	def render_json_show(success, error, error_status=500)
		if success
			render :show
		else
			render json: { message: error }, status: error_status
		end
	end
end
