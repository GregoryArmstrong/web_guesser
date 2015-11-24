require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)
number = SECRET_NUMBER

def check_guess(num)
  if num.to_i > (SECRET_NUMBER + 5)
    "Way too high!"
  elsif num.to_i > SECRET_NUMBER
    "Too high!"
  elsif num.to_i < (SECRET_NUMBER - 5)
    "Way too low!"
  elsif num.to_i == SECRET_NUMBER
    "You got it right!"
  else
    "Too low!"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:number => number, :message => message}
end
