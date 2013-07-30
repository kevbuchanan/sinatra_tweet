get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
  @user = User.find_or_create_by_username(@access_token.params[:screen_name])
  p @user
  @user.update_attributes(oauth_token: @access_token.params[:oauth_token], oauth_secret: @access_token.params[:oauth_token_secret])
  p @user
  session[:id] = @user.id
  redirect to('/')
end

post '/tweet/create' do 
  text = params[:tweet][:text]
  client = Twitter::Client.new(oauth_token: current_user.oauth_token, oauth_token_secret: current_user.oauth_secret)
  p client
  @tweet = client.update(text)
  erb :_tweet_status, layout: false
end
