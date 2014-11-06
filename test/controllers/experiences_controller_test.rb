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

  test '#show json response' do
    experience = Experience.create! title: 'title', description: 'description', price: 0
    experience.votes.create up: true
    experience.emotions.create name: 'angry'
    experience.categories.create name: 'artsy'

    get :show, id: experience.id, format: :json

    json = JSON.parse response.body
    experience_json = json['experience']

    assert_response 200
    assert_equal experience.title, experience_json['title']
    assert_equal experience.description, experience_json['description']
    assert_equal 1, experience_json['rating']
    assert_equal ['angry'], experience_json['emotion_names']
    assert_equal ['artsy'], experience_json['category_names']
  end

  test '#show not found json response' do
    get :show, id: 999, format: :json

    json = JSON.parse response.body

    assert_response 404
    assert_equal 'ActiveRecord::RecordNotFound: 999', json['message']
  end

  test '#index' do
    experiences = create_experiences
    get :index, format: :json

    json = JSON.parse response.body
    experiences_json = json['experiences']

    assert_response 200
    assert_equal experiences.count, experiences_json.count
    experience_json = experiences_json.first
    refute_nil experience_json['title']
    refute_nil experience_json['description']
    refute_nil experience_json['rating']
    refute_nil experience_json['emotion_names']
  end

  test '#index with filters' do
    experiences = create_experiences
    filters = { 'keywords' => ['title'], 'price' => 0, 'emotions' => ['angry']}
    ExperienceRepository.any_instance.expects(:search).with(filters).returns experiences
    
    get :index, filters: filters, format: :json

    assert_response 200
  end

  def create_experiences
    cat_1 = Category.create name: 'cat_1'
    cat_2 = Category.create name: 'cat_2'
    experiences = []
    experiences << Experience.create!(title: 'Title 1', description: 'description 1', user_id: current_user.id, price: 0, updated_at: Time.now)
    experiences << Experience.create!(title: 'title 2', description: 'description 2', user_id: 999, price: 1, updated_at: Time.now - 1.days)
    experiences << Experience.create!(title: 'abc', description: 'cde', user_id: 999, price: 1, updated_at: Time.now - 2.days)
    experiences.first.emotions.create name: 'anger'
    experiences.last.emotions.create name: 'anger'
    experiences.last.emotions.create name: 'happy'
    experiences.second.categories.create name: 'art'
    experiences.last.categories.create name: 'video-games'
    experiences
  end
end
