require 'test_helper'

class ExperienceRepositoryTest < ActiveSupport::TestCase
  def setup
  	@repo = ExperienceRepository.new current_user, belongs_to_user: true
  end

  test '#search' do
    assert_equal 0, @repo.search.count
  	experience_count = create_experiences.count
  	results = @repo.search
  	assert_equal experience_count, results.count
  end

  test '#search for keywords matches start of words in title and description' do
  	create_experiences
  	results = @repo.search keywords: ['title']
  	assert_equal 2, results.size

  	results = @repo.search keywords: ['description', '1']
  	assert_equal 1, results.size

  	results = @repo.search keywords: ["title 1"]
  	assert_equal 1, results.size

  	results = @repo.search keywords: ['abc']
  	assert_equal 1, results.size

  	results = @repo.search keywords: ['ab', 'cde']
  	assert_equal 1, results.size

  	results = @repo.search keywords: ['abc', 'title']
  	assert_equal 0, results.size

  	results = @repo.search keywords: ['nope']
  	assert_equal 0, results.size
  end

  test '#search for emotion with names' do
  	create_experiences
  	results = @repo.search emotions: ['anger']
  	assert_equal 2, results.size

  	results = @repo.search emotions: ['anger', 'happy']
  	assert_equal 2, results.size

  	results = @repo.search emotions: ['anger', 'happy', 'sad']
  	assert_equal 2, results.size

  	results = @repo.search emotions: ['sad']
  	assert_equal 0, results.size
  end

  test '#search for emotion with ids' do
    create_experiences
    results = @repo.search emotions: [Emotion.first.id]
    assert_equal 1, results.size

    results = @repo.search emotions: [999]
    assert_equal 0, results.size
  end

  test '#search for category with names' do
  	create_experiences
  	results = @repo.search categories: ['art']
  	assert_equal 1, results.size

  	results = @repo.search categories: ['ART']
  	assert_equal 1, results.size

  	results = @repo.search categories: ['ART', 'video-games']
  	assert_equal 2, results.size

  	results = @repo.search categories: [nil]
  	assert_equal 0, results.size
  end

  test '#search order_by' do
    experiences = create_experiences
    results = @repo.search({}, 'updated_at')
    assert_equal experiences.map(&:id).reverse, results.map(&:id)
  end

  test '#search by arbitrary attributes' do
  	create_experiences
  	results = @repo.search price: 0
  	assert_equal 1, results.size

  	results = @repo.search user_id: current_user.id
  	assert_equal 1, results.size

  	results = @repo.search price: 0, user_id: current_user.id
  	assert_equal 1, results.size

  	results = @repo.search price: 0, user_id: 999
  	assert_equal 0, results.size
  end

  test '#search limit_by' do
    experiences = create_experiences
    results = @repo.search({}, 'updated_at', 2)
    assert_equal 2, results.size
    refute_equal experience.size, results.size
  end

  test '#search for location' do
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