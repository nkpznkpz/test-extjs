require 'test_helper'

class ClientContactRecordsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_contact_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_contact_record" do
    assert_difference('ClientContactRecord.count') do
      post :create, :contact_record => { }
    end

    assert_redirected_to client_contact_record_path(assigns(:contact_record))
  end

  test "should show client_contact_record" do
    get :show, :id => client_contact_records(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => client_contact_records(:one).to_param
    assert_response :success
  end

  test "should update client_contact_record" do
    put :update, :id => client_contact_records(:one).to_param, :contact_record => { }
    assert_redirected_to client_contact_record_path(assigns(:contact_record))
  end

  test "should destroy client_contact_record" do
    assert_difference('ContactRecord.count', -1) do
      delete :destroy, :id => client_contact_records(:one).to_param
    end

    assert_redirected_to client_contact_records_path
  end
end