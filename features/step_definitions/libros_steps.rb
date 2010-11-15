Dado /^que existen los siguientes usuarios:$/ do |usuarios|
  usuarios.hashes.each do |info| 
    User.new(info).save!
  end
end

Dado /^que existen los siguientes libros:$/ do |libros|
  libros.hashes.each do |libro| 
    Book.create!(libro)
  end
end

