module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /la página raíz/
      '/'
    when /login/
      new_user_session_path
    when /la página de registro/
      new_user_registration_path
    when /la página de agregar libros/
      new_book_path
    when /la página de buscar libros/
      search_books_path
    when /la página del (\d+)to libro/
      "/books/#{($1)}"
    when /la página del libro "([^"]*)" de "([^"]*)"/
      "/books/#{Book.find_by_title_and_author($1, $2).id}"
    when /la página de perfil de "([^"]*)"/
      user_path(User.find_by_username($1))
    when /la página de reseñas del libro "([^"]*)" de "([^"]*)"/
      book_reviews_path(Book.find_by_title_and_author($1, $2))
    when /la página de la reseña (\d+) de "([^"]*)" de "([^"]*)"/
      id =  Book.find_by_title_and_author($2, $3).reviews.all[$1.to_i-1]
      book_review_path(Book.find_by_title_and_author($2, $3), id)
    when /la página de edición de la reseña (\d+) de "([^"]*)" de "([^"]*)"/
      id =  Book.find_by_title_and_author($2, $3).reviews.all[$1.to_i-1]
      edit_book_review_path(Book.find_by_title_and_author($2, $3), id)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
