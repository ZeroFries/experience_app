require 'test_helper'

class ExperiencesControllerTest < ActionController::TestCase
  def setup
  	current_user
  end

  test '#create json response' do
  	experience = Experience.new title: 'title', description: 'description', price: 0

  	post :create, experience: experience.as_json, format: :json

  	json = JSON.parse response.body
  	experience_json = json['experience']

  	assert_response 200
  	assert_equal experience.title, experience_json['title']
  	assert_equal experience.description, experience_json['description']
  	refute_nil experience_json['id']
  end

  test '#create error json response' do
  	experience = Experience.new title: 'title', description: 'description', price: 0

  	post :create, experience: experience.as_json.merge('bad_attribute' => 1), format: :json

		assert_response 500
  	json = JSON.parse response.body
  	assert_equal 'unknown attribute: bad_attribute', json['message']
  end

  test '#index' do
  end

  def create_experiences
  end
end
