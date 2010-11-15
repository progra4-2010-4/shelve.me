#Shelve.me

Un repaso de aplicaciones básicas en ruby on rails.

Algunos gems importantes que usaremos:

* [devise](https://github.com/plataformatec/devise)
* [jquery-rails](https://github.com/rails/jquery-ujs)
* [cucumber](https://github.com/aslakhellesoy/cucumber)
* [formtastic](https://github.com/justinfrench/formtastic)

Referencias:

* [wiki de cucumber](https://github.com/aslakhellesoy/cucumber/wiki/_pages)
* [guías de rails](http://guides.rubyonrails.org/)


#Instalación

* Ejecutar `bundle install`
* Correr `rake db:migrate` para crear la estructura de bases de datos
* Correr `rake db:seed` para agregar algunos libros de prueba
* Ejecutar rake cucumber && rake test. Las pruebas deberían salir en rojo al principio de la semana y en verde al final
  pero no debería haber errores negros (problemas con librerías, etc).
