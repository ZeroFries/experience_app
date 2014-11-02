class BaseRepository
	attr_accessor :current_user, :opts
	SANITIZED_PARAMS = [:id, :created_at, :updated_at, :created_by_name, :updated_by_name]


	def initialize(current_user, opts={})
		@current_user = current_user
		@opts = opts
	end

	def create(attributes={})
		attributes = sanitize_attributes attributes
		attributes.merge!(user_id: current_user.id) if opts[:belongs_to_user] 

		begin
			instance_obj = klass.send :new, attributes
			success = instance_obj.save
			error = instance_obj.errors.full_messages.join(', ')
		rescue ActiveRecord::UnknownAttributeError => error
			success = false
		end

		return instance_obj, success, error.to_s
	end

	def find_and_update_all(attributes_array)
		updated_models = []
		success, error = nil, nil
		klass.send :transaction do
			begin
				updated_models = attributes_array.map do |attributes|
					model, success, error = find_and_update(attributes)
					raise error unless success
					model
				end
			rescue Exception => error
				raise ActiveRecord::Rollback
			end
		end

		success = attributes_array.nil? ? false : (updated_models.size == attributes_array.size)
		return updated_models, success, error.to_s
	end

	def find_and_update(attributes)
		model, successful_find, find_error = find_by_id (attributes[:id] || attributes['id'])
		return model, false, find_error unless successful_find

		model, success, error = update model, attributes
		return model, success, error
	end
 
	def delete(id)
		klass.delete id
	end

	def find_by_id(id)
		models, success = find({id: id})
		error = "#{ActiveRecord::RecordNotFound}: #{id}" unless success
		return models.first, success, error
	end

	def find(query)
		models = klass.send :where, query
		return models, models.any?
	end

	def update(model, attributes)
		attributes = sanitize_attributes attributes
		attributes.merge!(user_id: @current_user.id) if opts['belongs_to_user']
		begin
			model.assign_attributes attributes
			success = model.save
			error = model.errors.full_messages.join(', ')
		rescue ActiveRecord::UnknownAttributeError => error
			success = false
		end

		return model, success, error.to_s
	end

	protected

	def sanitize_attributes(attributes)
		return {} if attributes.blank?
		attributes = symbolize_attributes attributes
		attributes.except! *(self.class.const_get(:SANITIZED_PARAMS) || [:id])
	end

	def symbolize_attributes(attributes)
		return {} if attributes.blank?
		attributes.symbolize_keys.merge!(attributes.dup.delete_if { |key| key if key.kind_of?(String) })
	end	
end