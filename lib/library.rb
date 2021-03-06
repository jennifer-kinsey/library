require "securerandom"

module Library
  def self.books
    Book.objectify(DB.exec("select * from books order by title"))
  end

  def self.patrons
    Patron.objectify(DB.exec("select * from patrons order by name"))
  end

  def self.search_by_author(author)
    Book.objectify(DB.exec("select * from books where UPPER(author) = UPPER('#{author}')"))
  end

  def self.search_by_title(title)
    Book.objectify(DB.exec("select * from books where UPPER(title) = UPPER('#{title}')"))
  end

  def self.search_by_keyword(keyword)
    Book.objectify(DB.exec("select * from books where UPPER(title) like UPPER('%#{keyword}%')"))
  end

  def self.search_by_book_id(book_id)
    Book.objectify(DB.exec("select * from books where id = '#{book_id}'"))
  end

  def self.search_by_patron_id(patron_id)
    Patron.objectify(DB.exec("select * from patrons where id = '#{patron_id}'"))
  end

  def self.check_out(book_id, patron_id)
    uuid = SecureRandom.uuid
    date = Time.now.strftime("%Y-%m-%d")
    if checked_out?(book_id)
      return
    else
      DB.exec("insert into records (id, patron_id, book_id, date_out)
              values ('#{uuid}', '#{patron_id}', '#{book_id}', '#{date}');")
    end
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
    available_books = []
    Library.books.each do |book|
      unless checked_out?(book.id)
        available_books.push(book)
      end
    end
    available_books
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

  def self.objectify(dataset)
    new_data = []

    new_data
  end
end
