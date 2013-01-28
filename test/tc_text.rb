require "birdcage"
require "test/unit"

class LossyferTest < Test::Unit::TestCase  
  def test_text
    params = {
      :api_key => 1234, :event_auth_token => 1, :phone_id => 1234,
      :display_name => "lossyfer", :time_originated => (Time.new.to_f * 1000).to_i
   }
    
    @l = LossyFer.new :options => {:priority => 2}
    @l.add params, "text", "Test"
  end
end
