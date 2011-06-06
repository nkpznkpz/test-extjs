require 'test_helper'

class ClientContractsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_contract" do
    assert_difference('ClientContract.count') do
      post :create, :client_contract => { }
    end

    assert_redirected_to client_contract_path(assigns(:client_contract))
  end

  test "should show client_contract" do
    get :show, :id => client_contracts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => client_contracts(:one).to_param
    assert_response :success
  end

  test "should update client_contract" do
    put :update, :id => client_contracts(:one).to_param, :client_contract => { }
    assert_redirected_to client_contract_path(assigns(:client_contract))
  end

  test "should destroy client_contract" do
    assert_difference('ClientContract.count', -1) do
      delete :destroy, :id => client_contracts(:one).to_param
    end

    assert_redirected_to client_contracts_path
  end
end
