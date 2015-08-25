require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
 
get '/' do
    # Find these values at twilio.com/user/account
    account_sid = ENV.fetch('TWILIO_ACCOUNT_SID')
    auth_token = ENV.fetch('TWILIO_AUTH_TOKEN')
    capability = Twilio::Util::Capability.new account_sid, auth_token
    # Create an application sid at twilio.com/user/account/apps and use it here
    capability.allow_client_outgoing ENV.fetch('TWILIO_APP_SID')
    capability.allow_client_incoming "example"
    token = capability.generate
    erb :index, :locals => {:token => token}
end

post '/voice' do
    response = Twilio::TwiML::Response.new do |r|
        r.Dial :callerId => '+15124002030' do |d|
            d.Client 'example'
        end
    end
    response.text
end
