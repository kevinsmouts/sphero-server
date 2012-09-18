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

def speed

if defined? @@current_speed
faster = @@current_speed + params[:inc].to_i
@@s.roll(faster,@@current_angle)
@@current_speed = faster
else
faster = params[:inc].to_i
@@s.roll(faster,0)
@@current_speed = faster
end

end


def turn

if defined? @@current_angle 
  if defined? @@current_speed
angle = @@current_angle + params[:angle].to_i
@@s.roll(@@current_speed,angle)
@@current_angle = angle
  else
    angle = @@current_angle + params[:angle].to_i
    @@s.roll(0,angle)
    @@current_angle = angle
  end

else
  if defined? @@current_speed
angle = params[:angle].to_i
@@s.roll(@@current_speed,angle)
@@current_angle = angle
else
  angle = params[:angle].to_i
  @@s.roll(0,angle)
  @@current_angle = angle
end
end

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
  @@current_speed = 0
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