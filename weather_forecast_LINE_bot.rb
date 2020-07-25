require 'json'
require_relative 'token'

def lambda_handler(event:, context:)
    
    require 'net/http'
    require 'json'
    require 'uri'
    
    res = Net::HTTP.get(URI.parse('http://api.openweathermap.org/data/2.5/weather?q=tokyo,jp&units=metric&lang=ja&appid=5f52d10cd78ff978e6a96927e68c2295'))
    name = JSON.parse(res)['name']
    weather = JSON.parse(res)['weather'][0]["description"]
    message = "#{name}の天気は#{weather}です"
    
    res = Net::HTTP.post(URI.parse('https://notify-api.line.me/api/notify'), "message=#{message}", {'Authorization': "Bearer #{TOKEN}"})
    
    # { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
    
end
