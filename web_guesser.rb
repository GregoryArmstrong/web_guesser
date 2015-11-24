require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

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

def reveal_message(guess, secret)
  "The SECRET NUMBER is #{secret}" if guess == secret
end

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  background = background_set(message)
  reveal = reveal_message(guess, SECRET_NUMBER)
  erb :index, :locals => {:reveal => reveal, :message => message, :background => background}
end
