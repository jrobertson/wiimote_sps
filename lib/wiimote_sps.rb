!/usr/bin/env ruby

# file: wiimote_sps.rb

require 'sps-pub'
require 'simple_wiimote'


class WiimoteSps < SimpleWiimote

  def initialize(device_id: 'wiimote', sps_address: nil, sps_port: 59000)

    raise "WiimoteSps: Please provide an SPS address.' unless sps_address

    super()
    @pub = SPSPub.new address: sps_address, port: sps_port
    @device_id = device_id

  end

  def notify(m)
    @pub.notice @device_id + '/input: ' + m
  end

  def onbtn_2_up(wm)         notify 'button 2 pressed'     end
  def onbtn_2_press(wm)                                    end
  def onbtn_1_up(wm)         notify 'button 1 pressed'     end
  def onbtn_1_press(wm)                                    end
  def onbtnb_press(wm)       notify 'button b pressed'     end
  def onbtnb_up(wm)                                        end
  def onbtnb_down(wm)                                      end
  def onbtn_a_press(wm)      notify 'button a pressed'     end
  def onbtn_minus_press(wm)  notify 'button minus pressed' end
  def onbtn_home_press(wm)   notify 'button home pressed'  end
  def onbtn_left_press(wm)   notify 'button left pressed'  end
  def onbtn_right_press(wm)  notify 'button right pressed' end
  def onbtn_down_press(wm)   notify 'button down pressed'  end
  def onbtn_up_press(wm)     notify 'button up pressed'    end
  def onbtn_plus_press(wm)   notify 'button plus pressed'  end
  
end

if __FILE__ == $0 then

  wm = WiimoteSps.new 
  wm.activate # ... then to deactivate press buttons 1 + 2

end
