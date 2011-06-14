require "rubygems"
require "sinatra"
require "smsified"

get '/' do
  "<h1>Welcome to the <a href='http://smsified.com'>SMSified</a> SMS Bar!</h1><p>You can now send SMS messages from your web browser's address bar using your SMSified account and the following format:</p><p>http://smsbar.heroku.com/username/password/from_smsified_number/to_mobile_number/encoded+message</p>"
end

get '/:username/:password/:from/:to/:message' do
  begin

    oneapi = Smsified::OneAPI.new :username => params[:username],
                                     :password => params[:password]

    oneapi.send_sms :address => params[:to],
                       :message => params[:message],
                       :sender_address => params[:from]
                       
    "Yay! Message sent to #{params[:to]}"

  rescue => error
    "Sad panda error message goes here - your SMS did not get delivered :("
  end
end