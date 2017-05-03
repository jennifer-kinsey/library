require "helper_spec"

describe "Library" do
  let(:new_book1) {Book.new({:title => "Great Expectations", :author => "Charles Dickens"})}
  let(:new_book2) {Book.new({:title => "Queen of the Damned", :author => "Ann Rice"})}
  let(:new_book3) {Book.new({:title => "Fountainhead", :author => "Ayn Rand"})}
  let(:new_book4) {Book.new({:title => "Shock Doctrine", :author => "Naomi Klein"})}
  let(:new_book5) {Book.new({:title => "The Selfish Gene", :author => "Richard Dawkins"})}

  let(:new_patron1) {Patron.new({:name => "Marilyn Monroe"})}
  let(:new_patron2) {Patron.new({:name => "Nelson Mandela"})}
  let(:new_patron3) {Patron.new({:name => "Kurt Cobain"})}
  let(:new_patron4) {Patron.new({:name => "Fred Astaire"})}
  let(:new_patron5) {Patron.new({:name => "Lucille Ball"})}
