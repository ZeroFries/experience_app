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
		@experience, success, error = @repo.update params[:experience]
		render_json_show success, error
	end

	def show
		@experience, success, error = @repo.find_by_id params[:id]
		render_json_show success, error, 404
	end

	def destroy
		@repo.delete params[:id]
		render json: { message: "Successfully deleted experience with id #{params[:id]}" }
	end

	def index
		@experiences = @repo.search params[:filters]
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
