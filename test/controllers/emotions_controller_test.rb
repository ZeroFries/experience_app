require 'test_helper'

class EmotionsControllerTest < ActionController::TestCase
  def setup
  	current_user
    @emotion1 = Emotion.create name: 'anger', label_colour: 'red'
    @emotion2 = Emotion.create name: 'happiness', label_colour: 'yellow'
    @emotion3 = Emotion.create name: 'melancholy', label_colour: 'blue'
  end

  test '#index' do
    get :index, format: :json

    json = JSON.parse response.body
    emotions_json = json['emotions']

    assert_response 200
    assert_equal 3, emotions_json.count
    emotion_json = emotions_json.first
    assert_equal 'Anger', emotion_json['name']
    assert_equal 'red', emotion_json['label_colour']
  end
end
