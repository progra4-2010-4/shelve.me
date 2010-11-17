#language: es
Característica: gestionar libros
    Para saber de los libros 
    Como usuario del servicio
    Quiero poder agregar reseñas 

    Antecedentes:
        Dado que existen los siguientes usuarios:
            |email             | password    | username  | 
            |frank@este.in     | drmrfrank   | drFrank   |
            |dr@acula.net      | bloodyeah   | vlad      |
        Y que existen los siguientes libros:
            |title                   | author              |   description |
            |The tempest          | William Shakespeare | written in 1610-11, about some island and stuff   |
            |La Vida Es Sueño     | Calderón de la Barca|  |
            |Huis Clos            | Jean-Paul Sartre    |  "l'enfer c'est les autres" |
            |La Vida Nueva        | Dante Alighieri     | sonnets and stuff           |
        Y que existen las siguientes reseñas:
            |libro| reseña | calidad | usuario |
            | Huis Clos| existentialiste |Bueno| vlad |
            | Huis Clos| No le entendí |Malo| drFrank |
            | La Vida Es Sueño | Es como inception |Regular| drFrank |

    Escenario: un usuario autenticado puede agregar reseñas
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página del libro "The Tempest" de "William Shakespeare"
        Y clickeo "Add Review"
        Y completo "Review" con "Es un libro genial"
        Y selecciono "regular" de "Quality"
        Y apreto "Create Review"
        Entonces debería estar en la página del libro "The Tempest" de "William Shakespeare"
        Y debería ver "1 review"
        Y debería ver "successfully added"


    Escenario: un usuario no autenticado no puede agregar reseñas
        Dado que no estoy autenticado
        Cuando voy a la página del libro "Huis Clos" de "Jean-paul Sartre"
        Entonces no debería ver "Add Review"
        Pero debería ver "2 reviews"

    Escenario: ver todas las reseñas de un libro
        Cuando voy a la página de reseñas del libro "Huis Clos" de "Jean-paul Sartre"
        Entonces debería ver "No le entendí"
        Y debería ver "by drFrank"
        Y debería ver "existentialiste"
        Y debería ver "by vlad"
    

    Escenario: ver reseñas individuales de un libro
        Cuando voy a la página de la reseña 1 de "La Vida Es Sueño" de "Calderón De La Barca"
        Entonces debería ver "Es como inception"
        Y debería ver "Regular"
        Y debería ver "drFrank"
        Pero no debería ver "Edit"
        Y no debería ver "Remove"

    Escenario: un usuario autenticado puede editar o destruir reseñas propias
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de la reseña 1 de "Huis Clos" de "Jean-paul Sartre"
        Entonces debería ver "Edit"
        Y debería ver "Remove"


    Escenario: un usuario no puede editar o destruir reseñas ajenas
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de la reseña 1 de "La Vida Es Sueño" de "Calderón De La Barca"
        Entonces no debería ver "Edit"
        Y no debería ver "Remove"

    Escenario: destruir reseñas
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de la reseña 1 de "Huis Clos" de "Jean-paul Sartre"
        Y clickeo "Remove"
        Entonces debería estar en la página del libro "Huis Clos" de "Jean-paul Sartre"
        Y debería ver "1 review"
        Y debería ver "removed"

    Escenario: editar reseñas
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de edición de la reseña 1 de "Huis Clos" de "Jean-paul Sartre"
        Y completo "Review" con "Ce n'est pas génial"
        Y selecciono "bad" de "Quality"
        Y apreto "Update Review"
        Entonces debería estar en la página del libro "Huis Clos" de "Jean-paul Sartre"
        Y debería ver "updated"  


