Dado /^que los siguientes usuarios han leído los siguientes libros:$/ do |info|
  #[{"usuario"=>"vlad", "libros"=>"The Tempest de William Shakespeare, La Vida Nueva de Dante Alighieri"}, {"usuario"=>"drFrank", "libros"=>"Huis Clos de Jean-Paul Sartre, The Tempest de William Shakespeare"}]
  info.hashes.each do |lectura|
    user = User.find_by_username lectura["usuario"]
    lectura["libros"].split(", ").each do |libro|
      titulo, autor = libro.split("de").collect{|e| e.strip}
      book = Book.find_by_title_and_author titulo, autor
      user.books << book
    end
  end
end

