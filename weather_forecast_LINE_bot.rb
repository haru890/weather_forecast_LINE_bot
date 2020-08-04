require 'json'
require_relative 'token'
require 'time'

def lambda_handler(event:, context:)
    
    require 'net/http'
    require 'json'
    require 'uri'
    
    res = Net::HTTP.get(URI.parse("http://api.openweathermap.org/data/2.5/weather?q=tokyo,jp&units=metric&lang=ja&appid=#{OPEN_WEATHER_MAP_API_KEY}"))
    
    name = JSON.parse(res)['name']
    weather = JSON.parse(res)['weather'][0]["description"]
    sunrise = Time.at(JSON.parse(res)['sys']["sunrise"]).getlocal('+09:00').strftime("%H:%M:%S")
    sunset = Time.at(JSON.parse(res)['sys']["sunset"]).getlocal('+09:00').strftime("%H:%M:%S")
    temp = JSON.parse(res)['main']['temp']
    humidity = JSON.parse(res)['main']['humidity']
    wind_speed = JSON.parse(res)['wind']['speed']
    
    message = "\n#{name}の天気は#{weather}です\n日の出は#{sunrise}です\n日没は#{sunset}です\n気温は#{temp}\n湿度は#{humidity}\n風速は#{wind_speed}"
    
    # message = <<"EOS"
    #   #{name}の天気は#{weather}
    #   日の出は#{sunrise}
    #   日没は#{sunset}
    #   気温は#{temp}
    #   湿度は#{humidity}
    #   風速は#{wind_speed}
    # EOS
    
    res = Net::HTTP.post(URI.parse('https://notify-api.line.me/api/notify'), "message=#{message}", {'Authorization': "Bearer #{LINE_TOKEN}"})
    
    # { statusCode: 200, body: JSON.generate('Hello from Lambda!') }
    
end
