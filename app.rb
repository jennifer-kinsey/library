require 'sinatra'
require 'sinatra/reloader'
require './lib/library'
require './lib/book'
require './lib/patron'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => "library"})

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

get('/admin') do
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

post('/book') do
  title = params.fetch('title')
  author = params.fetch('author')
  book = Book.new({:title => title, :author => author})
  book.save
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

get '/book/:id' do
  book_id = params.fetch("id")
  @book = Library.search_by_book_id(book_id).first
  erb (:modify_book)
end

post('/admin_patron') do
  name = params.fetch('name')
  patron = Patron.new({:name => name})
  patron.save
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

get '/admin_patron/:id' do
  patron_id = params.fetch("id")
  @checked_out_books = Library.checked_out_by_patron(patron_id).to_a
  @patron = Library.search_by_patron_id(patron_id).first
  erb(:modify_patron)
end

patch '/admin_patron' do
  name = params.fetch('name')
  patron_id = params.fetch('patron_id')
  @patron = Library.search_by_patron_id(patron_id).first
  @patron.update_attribute("name", name)
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

delete '/admin_patron' do
  patron_id = params.fetch('patron_id')
  @patron = Library.search_by_patron_id(patron_id).first
  @patron.delete
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

patch '/book' do
  title = params.fetch('title')
  author = params.fetch('author')
  book_id = params.fetch('book_id')
  @book = Library.search_by_book_id(book_id).first
  @book.update_attribute("title", title)
  @book.update_attribute("author", author)
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

delete '/book' do
  book_id = params.fetch('book_id')
  @book = Library.search_by_book_id(book_id).first
  @book.delete
  @patrons = Library.patrons
  @books = Library.books
  erb(:admin)
end

get '/patrons' do
  @patrons = Library.patrons
  erb(:patrons)
end

get '/patron/:id' do
  patron_id = params.fetch('id')
  @patron = Library.search_by_patron_id(patron_id).first
  @checked_out_books = Library.checked_out_by_patron(patron_id).to_a
  @books = Library.books
  erb(:patron_profile)
end

get '/checkout/:id' do
  id = params.fetch('id').split("!")
  book_id = id[0]
  patron_id = id[1]
  Library.check_out(book_id, patron_id)
  @patron = Library.search_by_patron_id(patron_id).first
  @checked_out_books = Library.checked_out_by_patron(patron_id).to_a
  @books = Library.books
  erb(:patron_profile)
end

get '/checkin/:id' do
  id = params.fetch('id').split("!")
  book_id = id[0]
  patron_id = id[1]
  Library.check_in(book_id, patron_id)
  @patron = Library.search_by_patron_id(patron_id).first
  @checked_out_books = Library.checked_out_by_patron(patron_id).to_a
  @books = Library.books
  erb(:patron_profile)
end
