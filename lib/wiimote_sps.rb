#!/usr/bin/env ruby

# file: wiimote_sps.rb


require 'sps-sub'
require 'simple_wiimote'


class WiimoteSps < SimpleWiimote

  def initialize(device_id: 'wiimote', sps_address: nil, sps_port: 59000, 
                 led_xor: true)

    raise 'WiimoteSps: Please provide a SPS addres' unless sps_address
    super()
    
    @device_id, @led_xor = device_id, led_xor

    @pub = @sub = SPSSub.new address: sps_address, callback: self

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
      when /^(buzz|vibrate|rumble|duration)/
        
        r = msg.match(/duration\s([\d\.]+)/)
        
        duration = r ? r.captures.first.to_f : 0.3
        
        self.rumble = true;  sleep duration;  self.rumble = false
        
      end      

    when /led$/

      r = msg.match(/(\d+)\s*(on|off|blink|stop)\s*([\d\.]+)?(?:\s*duration\s)?([\d\.]+)?/)

      if r then
        index, state, seconds, raw_duration = r.captures
        duration = raw_duration ? raw_duration.to_f : nil

        a = case state

          when 'on'
            [:on, duration]

          when 'off'
            [:off]
            
          when 'blink'
            seconds = seconds ? seconds.to_f : 0.5
            [:blink, seconds, duration: duration]
            
          when 'stop'
            [:off]

        end
        
        @led.each {|x| x.send :off} if @led_xor
        @led[index.to_i].send(*a) if index.to_i < @led.length
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
