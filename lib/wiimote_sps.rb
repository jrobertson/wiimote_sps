#!/usr/bin/env ruby

# file: wiimote_sps.rb

require 'sps-pub'
require 'sps-sub'
require 'simple_wiimote'


class WiimoteSps < SimpleWiimote

  def initialize(device_id: 'wiimote', sps_address: nil, sps_port: 59000)

    raise 'WiimoteSps: Please provide a SPS addres' unless sps_address
    super()
    @device_id = device_id
    @pub = SPSPub.new address: sps_address
    @sub = SPSSub.new address: sps_address, callback: self


    @pub.notice @device_id + '/info: wiimote initialized'

  end
  
  def activate

    Thread.new do      
      @sub.subscribe topic: 'wiimote/output/#'
    end
        
    super()

  end
  
  def ontopic(topic, msg)

    case topic
    when /rumble$/
     
      case msg
      when /^buzz/
        self.rumble = true
        sleep 0.3
        self.rumble = false
      end      

    when /led$/
      case msg
      when /(\d+)\s+(on|off)/
        self.led = ($2) == 'on' ? 1 : 0
      end
    end   
  end     

  def notify(m)
    @pub.notice @device_id + '/input: ' + m    
  end  
  
  def on_btn_2_up(wm)      notify 'button 2 pressed'     end
  def on_btn_1_up(wm)      notify 'button 1 pressed'     end
  def on_btn_b_press(wm)   notify 'button b pressed'     end
  def on_btn_b_up(wm)     end
  def on_btn_b_down(wm)   end
  def on_btn_a_press(wm)      notify 'button a pressed'     end
  def on_btn_minus_press(wm)  notify 'button minus pressed' end
  def on_btn_home_press(wm)   notify 'button home pressed'  end
  def on_btn_left_press(wm)   notify 'button left pressed'  end
  def on_btn_right_press(wm)  notify 'button right pressed' end
  def on_btn_down_press(wm)   notify 'button down pressed'  end
  def on_btn_up_press(wm)     notify 'button up pressed'    end
  def on_btn_plus_press(wm)   notify 'button plus pressed'  end
    
  def on_deactivated()
    EventMachine.stop
  end
  
  
end