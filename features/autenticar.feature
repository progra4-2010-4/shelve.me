#language: es
Característica: Autenticar usuarios
    Para poder crear retos
    Como un participante
    Quiero estar identificado y autenticado 
    
    Antecedentes: 
        Dado que los siguientes usuarios existen:
            | username | email           | password    |
            | jgalt    | galt@domain.com | foobarbaz   |
            | ragnard  | ragnar@net.com  | supersecret |

    Escenario: Un usuario no autenticado entra
        Dado que no estoy autenticado
        Cuando voy a la página raíz
        Entonces debería ver "Login"
        Y debería ver "Register"

    Escenario: Un usuario se registra
        Dado que no estoy autenticado
        Cuando voy a la página de registro
        Y completo "Username" con "lfborjas"
        Y completo "Email" con "self@lfborjas.com"
        Y completo "Password" con "supersecretstuff"
        Y completo "Password confirmation" con "supersecretstuff"
        Y apreto "Sign up"
        Entonces debería ver "signed up successfully"

    Escenario: Un usuario autenticado entra
        Dado que estoy autenticado como "jgalt"
        Cuando voy a la página raíz
        Entonces debería ver "jgalt"
        Y debería ver "Logout"
        Pero no debería ver "Register"
        Y no debería ver "Login"
