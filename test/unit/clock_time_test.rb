require 'test_helper'

class ClockTimeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should_get_time_to_update" do
    test_clock_time = clock_times(:clock_time_1)
    puts test_clock_time.inspect
  end
end
