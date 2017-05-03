require "securerandom"

module Library
  def self.books
    DB.exec("select * from books")
  end

  def self.patrons
    DB.exec("select * from patrons")
  end

  def self.search_by_author(author)
    DB.exec("select * from books where UPPER(author) = UPPER('#{author}')")
  end

  def self.search_by_title(title)
    DB.exec("select * from books where UPPER(title) = UPPER('#{title}')")
  end

  def self.search_by_keyword(keyword)
    DB.exec("select * from books where UPPER(title) like UPPER('%#{keyword}%')")
  end

  def self.search_by_book_id(book_id)
    DB.exec("select * from books where id = '#{book_id}'")
  end

  def self.search_by_patron_id(patron_id)
    DB.exec("select * from patrons where id = '#{patron_id}'")
  end

  def self.check_out(book_id, patron_id)
    uuid = SecureRandom.uuid
    date = Time.now.strftime("%Y-%m-%d")
    DB.exec("insert into records (id, patron_id, book_id, date_out)
            values ('#{uuid}', '#{patron_id}', '#{book_id}', '#{date}');")
  end

  def self.check_in(book_id, patron_id)
    date = Time.now.strftime("%Y-%m-%d")
    DB.exec("UPDATE records SET date_in = '#{date}' WHERE book_id = '#{book_id}'             AND date_in IS NULL;")

  end

  def self.checked_out_by_patron(patron_id)
    # returns all books and due dates sorted by date for a single patron
    # only books that have not been checked back in
    DB.exec("SELECT * FROM records where patron_id ='#{patron_id}' AND date_in IS NULL;")
  end

  def self.checked_out?(book_id)
    DB.exec("select * from records where book_id = '#{book_id}'
             and date_in is null").to_a.length > 0
  end

  def self.available_books
    # reurns a list of books currently available to be checked out
    # book cannot be checked out
    # book can be checked out if checked back in
  end

  def self.checked_out_books
    DB.exec("SELECT * FROM records WHERE date_in is null ORDER BY date_out DESC;").to_a
  end

  def self.overdue_books
    # returns overdue books and how many days overdue sorted by longest overdue
    # book has to have been checked out over 21 days ago
  end

  def self.history_of_patron(patron_id)
    DB.exec("SELECT * FROM records where patron_id ='#{patron_id}' ORDER BY date_out;")
  end

  def self.due_date(book_id)
    # returns the date a book is due
    # should return date 21 days after book was checked in
  end

end
