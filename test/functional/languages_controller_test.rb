require 'test_helper'

class LanguagesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:languages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create languages" do
    assert_difference('Languages.count') do
      post :create, :languages => { }
    end

    assert_redirected_to languages_path(assigns(:languages))
  end

  test "should show languages" do
    get :show, :id => languages(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => languages(:one).to_param
    assert_response :success
  end

  test "should update languages" do
    put :update, :id => languages(:one).to_param, :languages => { }
    assert_redirected_to languages_path(assigns(:languages))
  end

  test "should destroy languages" do
    assert_difference('Languages.count', -1) do
      delete :destroy, :id => languages(:one).to_param
    end

    assert_redirected_to languages_path
  end
end
