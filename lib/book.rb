require "securerandom"

class Book

  attr_accessor(:id, :title, :author)

  def initialize (attributes)
    self.id = SecureRandom.uuid
    self.title = attributes.fetch(:title)
    self.author = attributes.fetch(:author)
  end

  def save
    DB.exec("INSERT INTO books (id, title, author) VALUES ('#{id}', '#{title}', '#{author}');")
  end

  def delete
    DB.exec("delete from books where id = '#{id}'")
  end

  def add_author
    #add a second, third, etc author to book
  end

  def update_attribute(type, name)
    self.send("#{type}=", name) #updates the object
    DB.exec("update books set #{type} = '#{name}' where id = '#{id}';")
  end

end
