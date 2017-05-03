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
    DB.exec("select * from books where id = '#{id}'")
  end

  def self.search_by_patron_id(patron_id)
    DB.exec("select * from patrons where id = '#{id}'")
  end

  def self.check_out(book_id, patron_id)
    # checks out a single book to a patron, assigns due date
  end

  def self.check_in(book_id, patron_id)
    # checks in a single book back to the library
  end

  def self.checked_out_by_patron(patron_id)
    # returns all books and due dates sorted by date for a single patron
  end

  def self.checked_out?(book_id)
    #returns a boolean t f if a book is checked out or not
  end

  def self.available_books
    # reurns a list of books currently available to be checked out
  end

  def self.checked_out_books
    #rerturns all checked out books and due dates
  end

  def self.overdue_books
    #returns overdue books and how many days overdue sorted by longest overdue
  end

  def self.history_of_patron(patron_id)
    # returns list of books a patron has checked out sorted by checked out date
  end

  def self.due_date(book_id)
    # returns the date a book is due
  end

end
