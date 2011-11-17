require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "POST /pages with an invalid page" do
    post :create, :format => :json, :page => { :name => "" }
    assert_equal 422, response.status
  end

  test "PUT /pages/:id with an invalid page" do
    page = Page.create! :name => "Dummy page"
    put :update, :format => :json, :id => page.id, :page => { :name => "" }
    assert_equal 422, response.status
    body = JSON.parse(response.body)
    assert_equal ["can't be blank"], body['name']
  end
end
