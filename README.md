# Introducing the Wiimote_sps Gem

## Prerequisites

The Wiimote_sps gem relies upon the [Simple_wiimote gem](http://www.jamesrobertson.eu/snippets/2013/jan/20/introducing-the-simp.html) which uses the [Cwiid gem](http://www.jamesrobertson.eu/snippets/2011/12/13/1157hrs.html) which uses the Cwiid and Boost development libraries. 

### Installation

The libraries can easily be loaded on to your machine by apt-get installing libcwiid-dev and libboost-dev.

Type `sudo apt-get install libcwiid-dev libboost-dev`

## Gem Installation

`gem install wiimote_sps`

## Example

To Active the Wiimote, buttons 1 + 2 were pressed at the same time

    require 'wiimote_sps'

    wm = WiimoteSps.new sps_address: 'sps'
    wm.activate

Observed:

<pre>
MESSAGE: wiimote/input: button left pressed
MESSAGE: wiimote/input: button down pressed
MESSAGE: wiimote/input: button up pressed
MESSAGE: wiimote/input: button b pressed
MESSAGE: wiimote/input: button minus pressed
MESSAGE: wiimote/input: button plus pressed
MESSAGE: wiimote/input: button home pressed
MESSAGE: wiimote/input: button 1 pressed
MESSAGE: wiimote/input: button 2 pressed
</pre>

To deactivate the Wiimote, buttons 1+2 were pressed at the same time.

## Resources

* ?wiimote_sps https://rubygems.org/gems/wiimote_sps?

wiimotesps gem wiimote sps debian
