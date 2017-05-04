require "securerandom"

class Patron

  attr_accessor(:id, :name)

  def initialize (attributes)
    self.id = attributes.fetch(:id, SecureRandom.uuid)
    self.name = attributes.fetch(:name, nil)
  end

  def save
    DB.exec("INSERT INTO patrons (id, name) VALUES ('#{id}', '#{name}');")
  end

  def update_attribute(type, name)
    self.send("#{type}=", name) #updates the object
    DB.exec("UPDATE patrons SET #{type} = '#{name}' WHERE id = '#{id}';")
  end

  def delete
    DB.exec("DELETE FROM patrons WHERE id ='#{id}';")
  end

  def self.objectify(dataset)
    dataset.map do |data|
      patron_id = data["patron_id"] ? data["patron_id"] : data["id"]
      Patron.new({id: patron_id, name: data["name"]})
    end
  end

end
