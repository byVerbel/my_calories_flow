require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "chart_graph" do
    mail = UserMailer.chart_graph
    assert_equal "Chart graph", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
