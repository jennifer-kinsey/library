require "securerandom"

class Patron

  attr_accessor(:id, :name)

  def initialize (attributes)
    @id = SecureRandom.uuid
    @name = attributes.fetch(:name)
  end

  def add_patron
    #add new patron
  end

  def update_patron
    #update patron name
  end

  def delete_patron
    #remove from database
  end

end
