class Book

  attr_accessor{:id, :title, :author}

  def initialize (attributes)
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
  end

  def save
    #pushes the book to the database
  end

  def delete
    #delete book from database
  end

  def add_author
    #add a second, third, etc author to book
  end

  def update_book
    #mod title, authors
  end
  
end
