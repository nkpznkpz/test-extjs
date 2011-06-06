require 'test_helper'

class ClientPosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_pos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_po" do
    assert_difference('ClientPo.count') do
      post :create, :client_po => { }
    end

    assert_redirected_to client_po_path(assigns(:client_po))
  end

  test "should show client_po" do
    get :show, :id => client_pos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => client_pos(:one).to_param
    assert_response :success
  end

  test "should update client_po" do
    put :update, :id => client_pos(:one).to_param, :client_po => { }
    assert_redirected_to client_po_path(assigns(:client_po))
  end

  test "should destroy client_po" do
    assert_difference('ClientPo.count', -1) do
      delete :destroy, :id => client_pos(:one).to_param
    end

    assert_redirected_to client_pos_path
  end
end
