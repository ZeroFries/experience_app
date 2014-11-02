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
end