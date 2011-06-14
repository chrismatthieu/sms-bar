require "rubygems"
require "sinatra"
require "smsified"

get '/' do
  '<html><head><style type="text/css"> body { background: url("/speech-bubble.jpg"); background-repeat:no-repeat; background-color: #124D9D; margin: 100 100px; font-size:large; }</style></head><body><h1>Welcome to the SMS Bar!</h1><p>You can now send SMS messages from your web browser\'s address bar using the following format:</p><p>http://smsbar.heroku.com/to_mobile_number/encoded+message</p><br/><p>Powered by <br/><a href="http://smsified.com"><img src="/header-logo.png"></a></p></body></html>'
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

get '/:to/:message' do
  begin

    oneapi = Smsified::OneAPI.new :username => 'smsbar',
                                     :password => 'smsbar1'

    oneapi.send_sms :address => params[:to],
                       :message => params[:message],
                       :sender_address => '4433058582'
                       
    '<html><head><style type="text/css"> body { background: url("/speech-bubble.jpg"); background-repeat:no-repeat; background-color: #124D9D; margin: 100 100px; font-size:large; }</style></head><body><h1>Yay! Message sent to ' +  params[:to] + '</h1><br/><p>Powered by <br/><a href="http://smsified.com"><img src="/header-logo.png"></a></p></body></html>'

  rescue => error
    "Sad panda error message goes here - your SMS did not get delivered :("
  end
end

