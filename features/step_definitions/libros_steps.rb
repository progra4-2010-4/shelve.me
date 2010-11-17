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

Dado /^que existen las siguientes reseñas:$/ do |reviews|
  reviews.hashes.each do |r|
    Review.create(:review=>r["reseña"], :quality=>r["calidad"],
                  :book=>Book.find_by_title(r["libro"]), :user=>User.find_by_username(r["usuario"]))
  end 
end
