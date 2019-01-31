require "application_system_test_case"

class ProductFilesTest < ApplicationSystemTestCase
  setup do
    @product_file = product_files(:one)
  end

  test "visiting the index" do
    visit product_files_url
    assert_selector "h1", text: "Product Files"
  end

  test "creating a Product file" do
    visit product_files_url
    click_on "New Product File"

    fill_in "Id", with: @product_file._id
    fill_in "Name", with: @product_file.name
    click_on "Create Product file"

    assert_text "Product file was successfully created"
    click_on "Back"
  end

  test "updating a Product file" do
    visit product_files_url
    click_on "Edit", match: :first

    fill_in "Id", with: @product_file._id
    fill_in "Name", with: @product_file.name
    click_on "Update Product file"

    assert_text "Product file was successfully updated"
    click_on "Back"
  end

  test "destroying a Product file" do
    visit product_files_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Product file was successfully destroyed"
  end
end
