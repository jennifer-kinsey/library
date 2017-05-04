require "securerandom"

class Book

  attr_accessor(:id, :title, :author, :date_out, :date_in, :date_renewed)

  #21 days in seconds
  DAYS_21 = 1814400

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

  def due_date
    unless date_renewed
      convert_string_to_date(date_out) + DAYS_21
    else
      date_renewed + DAYS_21
    end
  end

  def self.objectify(dataset)
    dataset.map do |data|
      book_id = data["book_id"] ? data["book_id"] : data["id"]
      Book.new({id: book_id, title: data["title"], author: data["author"],
        date_out: data["date_out"], date_in: data["date_in"], date_renewed: data["date_renewed"]})
    end
  end

  private

  def convert_string_to_date(string)
    year = string.slice(0,4).to_i
    month = string.slice(5,2).to_i
    day = string.slice(8,2).to_i
    Time.new(year, month, day)
  end

end
