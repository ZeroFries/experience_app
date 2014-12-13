require 'test_helper'

class BaseRepositoryTest < ActiveSupport::TestCase
  def setup
  	BaseRepository.any_instance.stubs(:klass).returns Category
  	@repo = BaseRepository.new current_user
  end

  test '#create' do
 		model, success, error = @repo.create name: 'name'

 		assert success	
 		assert_empty error
 		assert model.reload
 		assert_equal @repo.klass, model.class
 		assert_equal 'name', model.name
  end

  test '#create sanitizes id' do
 		model, success, error = @repo.create name: 'name', id: 999

 		assert success	
 		assert_empty error
 		assert model.reload
 		assert_equal @repo.klass, model.class
 		assert_equal 'name', model.name
 		refute_equal 4, model.id
  end

  test '#create with belongs_to_user option' do
  	BaseRepository.any_instance.stubs(:klass).returns Comment
  	@repo.opts = {belongs_to_user: true}
 		model, success, error = @repo.create text: 'text'

 		assert success
 		assert_equal current_user.id, model.user_id
 		assert_equal current_user, model.user
  end

  test '#create with bad attribute errors' do
 		model, success, error = @repo.create name: 'name', fake_attribute: 'fake_attribute'

 		refute success
 		assert_equal "unknown attribute: fake_attribute", error
  end

  test '#create with validation errors' do
 		model, success, error = @repo.create

 		refute success
 		assert_equal "Name can't be blank", error
  end

  test '#find_and_update_all' do
  	models = 3.times.map {|i| Category.create(name: "name #{i}")}
  	model_attributes = models.map.with_index {|m, i| m.attributes.dup.merge(name: "name #{i+3}")}

  	models, success, error = @repo.find_and_update_all model_attributes

  	assert success
  	assert_empty error

  	models.each_with_index do |m, i|
  		assert m.reload
  		assert_equal "name #{i+3}", m.name
  	end
  end

  test '#find_and_update_all with bad attribute error' do
  	models = 3.times.map {|i| Category.create(name: "name #{i}")}
  	model_attributes = models.map.with_index {|m, i| m.attributes.dup.merge(name: "name #{i+3}")}
  	model_attributes.second.merge! fake_attribute: 'fake_attribute'

  	models, success, error = @repo.find_and_update_all model_attributes

  	refute success
  	assert_equal "unknown attribute: fake_attribute", error

  	models.each_with_index do |m, i|
  		assert m.reload
  		assert_equal "name #{i}", m.name
  	end
  end

  test '#find_and_update_all with model not found' do
  	models = 3.times.map {|i| Category.create(name: "name #{i}")}
  	model_attributes = models.map.with_index {|m, i| m.attributes.dup.merge(name: "name #{i+3}")}
  	model_attributes.second.merge! id: 999

  	models, success, error = @repo.find_and_update_all model_attributes

  	refute success
  	assert_equal "ActiveRecord::RecordNotFound: 999", error

  	models.each_with_index do |m, i|
  		assert m.reload
  		assert_equal "name #{i}", m.name
  	end
  end

  test '#find_and_update with validation error' do
  	model = Category.create! name: "name"
  	model_attributes = model.attributes.dup.merge(name: nil)

  	model, success, error = @repo.find_and_update model_attributes

  	refute success
  	assert_equal "Name can't be blank", error
  end
end