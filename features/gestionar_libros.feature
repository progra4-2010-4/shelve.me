#language: es
Característica: gestionar libros
    Para tener una base de libros
    Como usuario del servicio
    Quiero poder agregar y buscar libros

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
    
    Escenario: agregar un libro nuevo
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de agregar libros
        Y completo "Title" con "Seis personajes en busca de un autor"
        Y completo "Author" con "Luigi Pirandello"
        Y apreto "Create Book"
        Entonces debería estar en la página del 5to libro
        Y debería ver "Seis Personajes En Busca De Un Autor"

    Escenario: agregar un libro repetido
        Dado que estoy autenticado como "drFrank"
        Cuando voy a la página de agregar libros
        Y completo "Title" con "La vida nueva"
        Y completo "Author" con "dante ALIGHIERI"
        Y apreto "Create Book"
        Entonces mostrame la página
        Y debería ver "Oops, we already know about that book, thanks anyway!"

    Escenario: buscar un libro
        Cuando voy a la página de buscar libros
        Y completo "Search for" con "vida"
        Y apreto "Search"
        Entonces mostrame la página
        Y debería ver "La Vida Es Sueño"
        Y debería ver "La Vida Nueva"
        Pero no debería ver "The Tempest"
        Y no debería ver "Huis Clos"

