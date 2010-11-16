Dado /^que no estoy autenticado$/ do
  #debería haber una ruta en nuestra aplicación a la cual ir para
  #des-autenticarse. Asumamos que existe y es /users/sign_out
  visit destroy_user_session_path
end

Dado /^que los siguientes usuarios existen:$/ do |table|
  table.hashes.each do |info|
    #la primera vez sería {:username=>"jgalt", :email=>"galt@domain.com", :password=>"foobarbaz"}
    User.new(info).save!
  end
end

Dado /^que estoy autenticado como "([^"]*)"$/ do |username|
  usuario = User.find_by_username username
  passwords = {"drFrank"=> "drmrfrank", "vlad"=>"bloodyeah", "jgalt"=>"foobarbaz"}

  Entonces %{voy a login}
  Y %{completo "Email" con "#{usuario.email}"}
  Y %{completo "Password" con "#{passwords[username]}"}
  Y %{apreto "Sign in"}
end

