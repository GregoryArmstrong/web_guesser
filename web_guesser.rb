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
  background = "red" if message.include?("Way")
  background = "pink" if !message.include?("Way")
  background = "green" if message.include?("right!")
  background
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
