require 'json'
require_relative 'token'
<<<<<<< HEAD
require 'time'
=======
>>>>>>> 94dd02c922a5cb54406483f26b8a25977b06f8c1

def lambda_handler(event:, context:)
    
    require 'net/http'
    require 'json'
    require 'uri'
    
    res = Net::HTTP.get(URI.parse("http://api.openweathermap.org/data/2.5/weather?q=tokyo,jp&units=metric&lang=ja&appid=#{OPEN_WEATHER_MAP_API_KEY}"))
    name = JSON.parse(res)['name']
    weather = JSON.parse(res)['weather'][0]["description"]
    sunrise = Time.at(JSON.parse(res)['sys']["sunrise"]).getlocal('+09:00').strftime("%H:%M:%S")
    sunset = Time.at(JSON.parse(res)['sys']["sunset"]).getlocal('+09:00').strftime("%H:%M:%S")
    message = "\n#{name}の天気は#{weather}です\n日の出は#{sunrise}です\n日没は#{sunset}です"
    
<<<<<<< HEAD
    res = Net::HTTP.post(URI.parse('https://notify-api.line.me/api/notify'), "message=#{message}", {'Authorization': "Bearer #{LINE_TOKEN}"})
=======
    res = Net::HTTP.post(URI.parse('https://notify-api.line.me/api/notify'), "message=#{message}", {'Authorization': "Bearer #{TOKEN}"})
>>>>>>> 94dd02c922a5cb54406483f26b8a25977b06f8c1
    
    # { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
    
end
