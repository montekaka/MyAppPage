require 'test_helper'

class PagecountsControllerTest < ActionController::TestCase
  setup do
    @pagecount = pagecounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pagecounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pagecount" do
    assert_difference('Pagecount.count') do
      post :create, pagecount: { pageview: @pagecount.pageview }
    end

    assert_redirected_to pagecount_path(assigns(:pagecount))
  end

  test "should show pagecount" do
    get :show, id: @pagecount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pagecount
    assert_response :success
  end

  test "should update pagecount" do
    patch :update, id: @pagecount, pagecount: { pageview: @pagecount.pageview }
    assert_redirected_to pagecount_path(assigns(:pagecount))
  end

  test "should destroy pagecount" do
    assert_difference('Pagecount.count', -1) do
      delete :destroy, id: @pagecount
    end

    assert_redirected_to pagecounts_path
  end
end
