require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
number = SECRET_NUMBER

def check_guess(num)
  message = "Too low!" if num < SECRET_NUMBER
  message = "Too high!" if num > SECRET_NUMBER
  message = "Way too low!" if num < (SECRET_NUMBER - 5)
  message = "Way too high!" if num > (SECRET_NUMBER + 5)
  message = "You got it right!" if num == SECRET_NUMBER
  message
end

def background_set(message)
  case message
  when "You got it right!"
    background = "green"
  when "Way too low!"
    background = "red"
  when "Way too high!"
    background = "red"
  when "Too low!"
    background = "pink"
  when "Too high!"
    background = "pink"
  end
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  background = background_set(message)
  erb :index, :locals => {:number => number, :message => message, :background => background}
end
