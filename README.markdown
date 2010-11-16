#Shelve.me

Un repaso de aplicaciones básicas en ruby on rails.

Algunos gems importantes que usaremos:

* [devise](https://github.com/plataformatec/devise)
* [jquery-rails](https://github.com/rails/jquery-ujs)
* [cucumber](https://github.com/aslakhellesoy/cucumber) para pruebas de integración
* [formtastic](https://github.com/justinfrench/formtastic) para forms más elegantes (OPCIONAL)
* [will_paginate](https://github.com/mislav/will_paginate/wiki/) para mostrar paginación en resultados (OPCIONAL)
* [web_app_theme](https://github.com/pilu/web-app-theme) para ponerle estilo rápido a la aplicación (OPCIONAL- **SOBREESCRIBE EL LAYOUT EN app/views/layout/application.html.erb)**.

Referencias:

* [wiki de cucumber](https://github.com/aslakhellesoy/cucumber/wiki/_pages)
* [guías de rails](http://guides.rubyonrails.org/)
* [railscasts](http://railscasts.com/)

#Entregables:

1. Autenticación de usuarios
2. Gestión de libros
3. Marcar libros como leídos, ver mis libros y los de otros; ver lectores de un libro
4. Agregar usuarios como amigos, enviar correo.


#Instalación

* Ejecutar `bundle install`
* Correr `rake db:migrate` para crear la estructura de bases de datos
* Correr `rake db:seed` para agregar algunos libros de prueba
* Ejecutar rake cucumber && rake test. Las pruebas deberían salir en rojo al principio de la semana y en verde al final
  pero no debería haber errores negros (problemas con librerías, etc).
* **OJO**: cuando estés usando generadores de rails, *te va a tirar conflicto* con las pruebas que ya están escritas. Rails te preguntará si deseás sobreescribirlas, **no las sobreescribás**, escribí `n` para que se salte la sobre-escritura. 

# Para poner en heroku:

* Si se usa [búsqueda en texto](http://railscasts.com/episodes/37-simple-search-form), tener presente esto: <http://stackoverflow.com/questions/3161108/rails-sql-query-with-wildcards-works-in-sqlite-but-not-postgresql>
* ejecutar: `heroku create` y luego `git push heroku master`. Si todo sale bien, la aplicación debería publicarse a heroku.
