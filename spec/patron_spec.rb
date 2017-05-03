require "helper_spec"

describe "Patron" do

  describe '#initialize' do
    it 'creates an initial patron object' do
      new_patron = Patron.new({:name => "Marilyn Monroe"})
      expect(new_patron.name).to eq "Marilyn Monroe"
    end
  end

end
