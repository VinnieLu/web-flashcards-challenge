def parser(filename)
  questions = []
  answers = []
  filename = APP_ROOT.to_s + "/db/#{filename}"
      File.open(filename).each do |line|
        if line.split("").include?("?")
             questions << line.chomp
        else
          answers << line.chomp if !line.empty?
        end
      end
      answers.delete("")
      questions.zip(answers).to_h
end

def load_deck(deck_name, data)
  data.each do |data_q, data_a|
    u = Card.new
    u.question = data_q
    u.answer = data_a
    u.deck_id = deck_name.id
    u.save
  end
end

def create_deck(filename)
data = parser(filename)
new_deck = Deck.create(name: "#{filename[0..-5]}")
load_deck(new_deck, data)
end


create_deck("nighthawk_deck.txt")
create_deck("otter_deck.txt")
create_deck("raccoon_deck.txt")
create_deck("platypus_deck.txt")



