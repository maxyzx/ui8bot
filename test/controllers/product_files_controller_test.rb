require 'test_helper'

class ProductFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product_file = product_files(:one)
  end

  test "should get index" do
    get product_files_url
    assert_response :success
  end

  test "should get new" do
    get new_product_file_url
    assert_response :success
  end

  test "should create product_file" do
    assert_difference('ProductFile.count') do
      post product_files_url, params: { product_file: { _id: @product_file._id, name: @product_file.name } }
    end

    assert_redirected_to product_file_url(ProductFile.last)
  end

  test "should show product_file" do
    get product_file_url(@product_file)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_file_url(@product_file)
    assert_response :success
  end

  test "should update product_file" do
    patch product_file_url(@product_file), params: { product_file: { _id: @product_file._id, name: @product_file.name } }
    assert_redirected_to product_file_url(@product_file)
  end

  test "should destroy product_file" do
    assert_difference('ProductFile.count', -1) do
      delete product_file_url(@product_file)
    end

    assert_redirected_to product_files_url
  end
end
