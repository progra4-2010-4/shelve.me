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
            | "The tempest"          | William Shakespeare | written in 1610-11, about some island and stuff   |
            | "La vida es sueño"     | Calderón de la Barca|  |
            | "Huis Clos"            | Jean-Paul Sartre    |  "l'enfer c'est les autres" |
            | "La vida nueva"        | Dante Alighieri     | sonnets and stuff           |
    
    Escenario: agregar un libro nuevo
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página de agregar libros
        Y mostrame la página
        Y completo "Title" con "Seis personajes en busca de un autor"
        Y completo "Author" con "Luigi Pirandello"
        Y apreto "Create Book"
        Entonces debería estar en la página del 5to libro
        Y debería ver "Seis personajes en busca de un autor"

    Escenario: agregar un libro repetido
        Dado que estoy autenticado como "drFrank"
        Cuando voy a la página de agregar libros
        Y completo "Title" con "La vida es sueño"
        Y completo "Author" con "Calderón de la Barca"
        Y apreto "Create Book"
        Entonces debería ver "Oops, we already know about that book, thanks anyway!"

    Escenario: buscar un libro
        Cuando voy a la página de buscar libros
        Y completo "Search for" con "vida"
        Y apreto "Search"
        Entonces debería ver "La vida es sueño"
        Y debería ver "La vida nueva"
        Pero no debería ver "The tempest"
        Y no debería ver "Huis Clos"

