require "helper_spec"

describe "Book" do
  let(:new_book) {Book.new({:title => "Great Expectations", :author => "Charles Dickens"})}

  describe '#initialize' do
    it 'creates an initial book object' do
      expect(new_book.title).to eq "Great Expectations"
    end
  end

  describe "#save" do
    it "saves a single record to the database" do
      new_book.save
      results = DB.exec("select * from books where id = '#{new_book.id}'").to_a
      expect(results.length).to eq 1
    end
  end

  describe "#delete" do
    it "deletes a single record to the database" do
      new_book.save
      new_book.delete
      results = DB.exec("select * from books where id = '#{new_book.id}'").to_a
      expect(results.length).to eq 0
    end
  end
end
