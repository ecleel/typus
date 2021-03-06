require "test_helper"

class ActiveRecordTest < ActiveSupport::TestCase

  should "verify mapping instance method with an array" do
    post = Factory(:post)
    assert_equal "published", post.mapping(:status)
  end

  should_eventually "verify mapping instance method with a 2 dimension array" do
    Post.send(:remove_const, :STATUS)
    Post::STATUS = [["Published", "published"], ["Pending", "pending"]]
    post = Factory(:post)
    assert_equal "Published", post.mapping(:status)
  end

  should "verify mapping instance method with an array when status if unpublished" do
    post = Factory(:post, :status => "unpublished")
    assert_equal "unpublished", post.mapping(:status)
  end

  should "verify mapping instance method with a hash" do
    page = Factory(:page)
    assert_equal "Published", page.mapping(:status)
    page = Factory(:page, :status => "unpublished")
    assert_equal "Not Published", page.mapping(:status)
  end

  should "verify to_label instance method" do
    assert_equal "admin@example.com", Factory(:typus_user).to_label
  end

  should "verify to_label instance method for post" do
    assert_match /Post#/, Factory(:post).to_label
  end

  should "verify to_resource instance method" do
    assert_equal "typus_users", TypusUser.to_resource
    assert_equal "delayed/tasks", Delayed::Task.to_resource
  end

end
