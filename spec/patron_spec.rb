require "helper_spec"

describe "Patron" do
  let(:new_patron) {Patron.new({:name => "Marilyn Monroe"})}
  let(:results) {DB.exec("SELECT * FROM patrons WHERE id = '#{new_patron.id}'").to_a}

  describe '#initialize' do
    it 'creates an initial patron object' do
      expect(new_patron.name).to eq "Marilyn Monroe"
    end
  end

  describe '#save' do
    it 'adds a new patron to the database' do
      new_patron.save
      expect(results.length).to eq 1
    end
  end

  describe '#update_attribute' do
    it 'updates the object and database with the new name' do
      new_patron.save
      new_patron.update_attribute("name", "Marilyn Manson")
      expect(results.first.fetch('name')).to eq "Marilyn Manson"
      expect(new_patron.name).to eq "Marilyn Manson"
    end
  end

  describe '#delete' do
    it 'deletes the patron from the database' do
      new_patron.save
      new_patron.delete
      expect(results.length).to eq 0
    end
  end

end
