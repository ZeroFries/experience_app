class ExperiencesController < ApplicationController
	def new
		@experience = Experience.new
	end

	def create
		repo = ExperienceRepository.new current_user, belongs_to_user: true
		@experience, success, error = repo.create params[:experience]
		if success
			render json: { experience: @experience }
		else
			render json: { message: error }, status: 500
		end
	end

	def edit
	end

	def update
	end

	def show
	end

	def destroy
	end

	def index
	end
end
