post '/deck/:deck_id/card/:card_id' do
	session[:guess] = params[:guess]
	redirect '/deck/:deck_id/card/:card_id'
end

get '/deck/:deck_id/card/:card_id' do
		if session[:counter] == nil
			session[:counter] = 0

			session[:deck] = Deck.find_by(id: params[:deck_id])
			@cards = Card.where(deck_id: params[:deck_id])
			session[:round] = Round.create(user_id: session[:user_id], deck_id: session[:deck].id, total_guesses: 0, first_correct: 0)
			session[:total_guesses] = session[:round].total_guesses
			session[:first_correct] = session[:round].first_correct

			session[:shuffled] = []
				@cards.each do |k|
					session[:shuffled] << k
				end
			session[:shuffled].shuffle!
		elsif session[:guess] == session[:shuffled][session[:counter]].answer
			session[:counter] += 1
			session[:first_correct] += 1
		end

		if session[:counter] < session[:shuffled].length
			session[:total_guesses] += 1
			erb :card
		else
			session[:counter] = nil
			redirect '/stats/#{session[:round]}'
		end
end