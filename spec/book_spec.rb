require "helper_spec"

describe "Book" do
  let(:new_book) {Book.new({:title => "Great Expectations", :author => "Charles Dickens"})}
  let(:results) {DB.exec("select * from books where id = '#{new_book.id}'").to_a}

  describe '#initialize' do
    it 'creates an initial book object' do
      expect(new_book.title).to eq "Great Expectations"
    end
  end

  describe "#save" do
    it "saves a single record to the database" do
      new_book.save
      expect(results.length).to eq 1
    end
  end

  describe "#delete" do
    it "deletes a single record to the database" do
      new_book.save
      new_book.delete
      expect(results.length).to eq 0
    end
  end

  describe "#update_attribute" do
    it ("updates the author with new author") do
      new_book.save
      new_book.update_attribute("author", "William Shakespeare")
      expect(results.first.fetch("author")).to eq "William Shakespeare"
      expect(new_book.author).to eq "William Shakespeare"
    end
    it ("updates the title with new title") do
      new_book.save
      new_book.update_attribute("title", "Hamlet")
      expect(results.first.fetch("title")).to eq "Hamlet"
      expect(new_book.title).to eq "Hamlet"
    end
  end
end
