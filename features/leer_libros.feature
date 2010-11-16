#language: es
#wip como en Work In Progress, se corre con rake cucumber:wip
Característica: marcar libros como leídos
    Para participar 
    Como lector
    Quiero marcar qué libros he leído

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
            |The Demon Haunted World | Carl Sagan       | not what you think          |
        Y que los siguientes usuarios han leído los siguientes libros:
            |usuario| libros |
            | vlad  | The Tempest de William Shakespeare, La Vida Nueva de Dante Alighieri |
            | drFrank | Huis Clos de Jean-paul Sartre, The Tempest de William Shakespeare  | 

    Esquema del escenario: ver página de libros leídos y no leídos
        Dado que estoy autenticado como "drFrank"
        Cuando voy a la página del libro "<libro>" de "<autor>"
        Entonces debería ver "<algo>"
        Y no debería ver "<otro>"

        Ejemplos:
            |libro| autor | algo | otro |
            |Huis Clos | Jean-paul Sartre | I've read it! | Mark as read?    |
            |La Vida Nueva | Dante Alighieri | Mark as read? | I've read it! |

    Esquema del escenario: no poder marcar si no estoy autenticado
        Dado que no estoy autenticado
        Cuando voy a la página del libro "<libro>" de "<autor>"
        Entonces no debería ver "I've read it"
        Y no debería ver "Mark as read?"
        Y no debería ver "Unmark"
        Ejemplos:
            |libro| autor |
            |Huis Clos | Jean-paul Sartre |
            |The Demon Haunted World | Carl Sagan  |

    Esquema del escenario: marcar libros como leídos
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página del libro "<libro>" de "<autor>"
        Y clickeo "Mark as read?"
        Entonces debería estar en la página del libro "<libro>" de "<autor>"
        Y debería ver "I've read it!"
        Y debería ver "Unmark"

        Ejemplos:
            |libro| autor |
            |Huis Clos | Jean-paul Sartre |
            |The Demon Haunted World | Carl Sagan  |
    

    Escenario: desmarcar un libro como leído
        Dado que estoy autenticado como "vlad"
        Cuando voy a la página del libro "The Tempest" de "William Shakespeare"
        Y clickeo "Unmark"
        Y voy a la página de perfil de "vlad"
        Entonces no debería ver "The Tempest"


    Esquema del escenario: ver libros leídos por usuario
        Cuando voy a la página de perfil de "<usuario>"
        Entonces debería ver "<ver>" 
        Y no debería ver "<nover>"

        Ejemplos:
            |usuario| ver           | no ver |
            | vlad  | La Vida Nueva | La Vida Es Sueño |
            | vlad  | The Tempest   | Huis Clos        |
            | drFrank | Huis Clos   | La Vida Nueva    |

    Esquema del escenario: ver lectores de un libro
        Cuando voy a la página del libro "<libro>" de "<autor>"
        Entonces <accion> 
        Y <otra_accion>

        Ejemplos:
            | libro| autor | accion | otra_accion |
            |The Tempest| William Shakespeare| debería ver "vlad" | debería ver "drFrank"|
            |La Vida Nueva | Dante Alighieri | debería ver "vlad" | no debería ver "drFrank"|

