class BooksController < ApplicationController
  def index
    books = Book.all.with_attached_cover

    render locals: { books: books }
  end

  def show
    book = Book.find(params[:id])

    render locals: { book: book }
  end
end
