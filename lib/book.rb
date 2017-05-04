require "securerandom"

class Book

  attr_accessor(:id, :title, :author, :date_out, :date_in, :date_renewed)

  def initialize (attributes)
    self.id = attributes.fetch(:id, SecureRandom.uuid)
    self.title = attributes.fetch(:title)
    self.author = attributes.fetch(:author)
    self.date_out = attributes.fetch(:date_out, nil)
    self.date_in = attributes.fetch(:date_in, nil)
    self.date_renewed = attributes.fetch(:date_renewed, nil)
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

  def self.objectify(dataset)
    dataset.map do |data|
      book_id = data["book_id"] ? data["book_id"] : data["id"]
      Book.new({id: book_id, title: data["title"], author: data["author"],
        date_out: data["date_out"], date_in: data["date_in"], date_renewed: data["date_renewed"]})
    end
  end

end
