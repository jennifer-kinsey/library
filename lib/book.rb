require "securerandom"

class Book

  attr_accessor(:id, :title, :author)

  def initialize (attributes)
    self.id = SecureRandom.uuid
    self.title = attributes.fetch(:title)
    self.author = attributes.fetch(:author)
  end

  def save
    result = DB.exec("INSERT INTO books (id, title, author) VALUES ('#{id}', '#{title}', '#{author}');")
  end

  def delete
    DB.exec("delete from books where id = '#{id}'")
  end

  def add_author
    #add a second, third, etc author to book
  end

  def update_book
    #mod title, authors
  end

end
