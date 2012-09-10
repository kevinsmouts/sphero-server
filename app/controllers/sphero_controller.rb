class SpheroController < ApplicationController
require 'sphero'

def index
  if defined? @@s
    redirect_to ('/sphero/controls/')
  else
    redirect_to ('/sphero/pair/')
  end
end
def pair
end

def new
  @@s = Sphero.new "/dev/tty.Sphero-"+ params[:name] +"-RN-SPP"
  redirect_to ('/')
end

def controls
end



def roll
  if params[:speed]
  speed = params[:speed].to_i
  heading = params[:heading].to_i
  @@s.roll(speed, heading)
  else
    @@s.roll(255,0)
  end
end  

def stop
  @@s.stop
end

def sleep
  @@s.sleep
end

def rgb
  red = params[:r].to_i
  green = params[:g].to_i
  blue = params[:b].to_i
 
  @@s.rgb(red, green, blue)
end

end