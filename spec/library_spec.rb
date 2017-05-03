require "helper_spec"

describe "Library" do
  let(:new_book1) {Book.new({:title => "Great Expectations", :author => "Charles Dickens"})}
  let(:new_book2) {Book.new({:title => "Queen of the Damned", :author => "Anne Rice"})}
  let(:new_book3) {Book.new({:title => "Fountainhead", :author => "Ayn Rand"})}
  let(:new_book4) {Book.new({:title => "Shock Doctrine", :author => "Naomi Klein"})}
  let(:new_book5) {Book.new({:title => "The Selfish Gene", :author => "Richard Dawkins"})}
  let(:new_book6) {Book.new({:title => "Interview with the Vampire", :author => "Anne Rice"})}
  let(:new_book7) {Book.new({:title => "Great Expectations", :author => "John Rivers"})}

  let(:new_patron1) {Patron.new({:name => "Marilyn Monroe"})}
  let(:new_patron2) {Patron.new({:name => "Nelson Mandela"})}
  let(:new_patron3) {Patron.new({:name => "Kurt Cobain"})}
  let(:new_patron4) {Patron.new({:name => "Fred Astaire"})}
  let(:new_patron5) {Patron.new({:name => "Lucille Ball"})}

  before do
    new_book1.save
    new_book2.save
    new_book3.save
    new_book4.save
    new_book5.save
    new_book6.save
    new_book7.save
    new_patron1.save
    new_patron2.save
    new_patron3.save
    new_patron4.save
    new_patron5.save
  end

  describe('.books') do
    it 'displays all the books' do
      expect(Library.books.to_a.length).to eq 7
    end
  end

  describe('.patrons') do
    it 'displays all the patrons' do
      expect(Library.patrons.to_a.length).to eq 5
    end
  end

  describe('.search_by_author') do
    it 'displays all the books by author' do
      expect(Library.search_by_author("anne rice").to_a.length).to eq 2
    end

    it 'displays all the books by author regardless of case' do
      expect(Library.search_by_author("aNNe rIce").to_a.length).to eq 2
    end
  end

  describe('.search_by_title') do
    it 'displays all the books that match a title' do
      expect(Library.search_by_title("great expectations").to_a.length).to eq 2
    end

    it 'displays all the books that match a title regardless of case' do
      expect(Library.search_by_title("GREAT expectations").to_a.length).to eq 2
    end
  end

  describe('.search_by_keyword') do
    it 'displays all the matching titles by keyword' do
      expect(Library.search_by_keyword("the").to_a.length).to eq 3
    end

    it 'displays all the matching titles by keyword regardless of case' do
      expect(Library.search_by_keyword("tHE").to_a.length).to eq 3
    end
  end

  describe('.search_by_book_id') do
    it 'displays the book that matches the id' do
      expect(Library.search_by_book_id(new_book1.id).first["id"]).to eq new_book1.id
    end
  end

  describe('.search_by_patron_id') do
    it 'displays the patron that matches the id' do
      expect(Library.search_by_patron_id(new_patron1.id).first["id"]).to eq new_patron1.id
    end
  end

  describe('.check_out') do
    it 'checks out a book by inserting a new line into the library records' do
      Library.check_out(new_book1.id, new_patron1.id)
      expect(DB.exec("select * from records").to_a.length).to eq 1
    end

    it 'checks to make sure the id of the book is in the right column' do
      Library.check_out(new_book1.id, new_patron1.id)
      expect(DB.exec("select * from records").to_a[0]["book_id"]).to eq new_book1.id
    end

    it 'checks out two books by inserting two new lines into the library records' do
      Library.check_out(new_book1.id, new_patron1.id)
      Library.check_out(new_book2.id, new_patron2.id)
      expect(DB.exec("select * from records").to_a.length).to eq 2
    end
  end

  describe('.check_in') do
    it 'checks in a book by updating the library record with the appropriate date' do
      date = Time.now.strftime("%Y-%m-%d")
      Library.check_out(new_book1.id, new_patron1.id)
      Library.check_in(new_book1.id, new_patron1.id)
      result = DB.exec("select * from records").to_a
      expect(result.first["date_in"]).to eq date
    end
  end

  describe('.checked_out?') do
    it 'returns true if a book is checked out' do
      Library.check_out(new_book1.id, new_patron1.id)
      expect(Library.checked_out?(new_book1.id)).to be true
    end
  end

end
