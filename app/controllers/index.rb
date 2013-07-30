get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/tweet/create' do 
  text = params[:tweet][:text]
  @tweet = Twitter.update(text)
  erb :_tweet_status, layout: false
end
